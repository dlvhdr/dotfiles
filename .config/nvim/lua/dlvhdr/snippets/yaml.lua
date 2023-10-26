local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.config.set_config({
  history = true,
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = false,
  store_selection_keys = "<c-s>",
})

local function get_line_iter(str)
  if str:sub(-1) ~= "\n" then
    str = str .. "\n"
  end

  return str:gmatch("(.-)\n")
end
local function box_trim_lines(str)
  local new_str = ""

  for line in get_line_iter(str) do
    line = line:gsub("^%s+", "")
    line = string.gsub(line, "%s+$", "")
    new_str = new_str .. "\n" .. line
  end

  return new_str
end

local function get_port_snip(args)
  if #args < 1 and not args[1][1] then
    return node(nil, text("hello world"))
  end

  local type = args[1][1]
  local indent = "      "

  if type == "NodePort" or type == "LoadBalancer" then
    return node(
      nil,
      fmt(
        box_trim_lines([[
        - port: {}
          {}targetPort: {}
          {}nodePort: {}
        ]]),
        {
          insert(1, "30000"),
          indent,
          insert(2, "80"),
          indent,
          insert(3, "30000"),
        }
      )
    )
  end

  if type == "ClusterIP" then
    return node(
      nil,
      fmt(
        [[
        - port: {}
        {}targetPort: {}
        ]],
        {
          insert(1, "30000"),
          indent,
          insert(2, "80"),
        }
      )
    )
  end
end

return {
  snip(
    {
      trig = "pod",
      namr = "k8s Pod",
      dscr = "Kubernetes Pod definition",
    },
    fmt(
      [[
                  apiVersion: v1
                  kind: Pod
                  metadata:
                    name: {}
                    labels:
                      {}: {}
                  spec:
                    containers:
                    - name: {}
                      image: {}:{}
                      ports:
                      - containerPort: {}
                ]],
      {
        insert(1, "nginx"),
        insert(2, "run"),
        insert(3, "nginx"),
        insert(4, "nginx"),
        insert(5, "nginx"),
        insert(6, "latest"),
        insert(7, "80"),
      }
    )
  ),
  snip(
    {
      trig = "deploy",
      namr = "k8s Deployment",
      dscr = "Kubernetes Deployment definition",
    },
    fmt(
      [[
                  apiVersion: apps/v1
                  kind: Deployment
                  metadata:
                    name: {}
                    labels:
                      {}
                  spec:
                    replicas: {}
                    selector:
                      matchLabels:
                        {}
                    template:
                      metadata:
                        labels:
                          {}
                      spec:
                        containers:
                        - name: {}
                          image: {}:{}
                          ports:
                          - containerPort: {}
                ]],
      {
        insert(1, "name"),
        insert(2, "label"),
        insert(3, "1"),
        insert(4, "label"),
        rep(4),
        insert(5, "container_name"),
        insert(6, "image"),
        insert(7, "1.0"),
        insert(8, "80"),
      }
    )
  ),
  snip(
    {
      trig = "service",
      namr = "k8s Service",
      dscr = "Kubernetes Service definition",
    },
    fmt(
      [[
                    apiVersion: v1
                    kind: Service
                    metadata:
                      name: {}
                      labels:
                        {}
                    spec:
                      selector:
                        {}
                      type: {}
                      ports:
                        {}
                ]],
      {
        insert(1, "name"),
        insert(2),
        insert(3),
        choice(4, {
          text("ClusterIP"),
          text("NodePort"),
          text("LoadBalancer"),
        }),
        dynamicn(5, get_port_snip, { 4 }),
      }
    )
  ),
}
