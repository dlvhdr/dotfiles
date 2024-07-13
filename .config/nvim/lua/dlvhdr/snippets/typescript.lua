local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippet = luasnip.s
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
local dynamic_node = luasnip.dynamic_node
local function_node = luasnip.function_node

-- Get a list of  the property names given an `interface_declaration`
-- treesitter *tsx* node.
-- Ie, if the treesitter node represents:
--   interface {
--     prop1: string;
--     prop2: number;
--   }
-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "interface declaration node"
---@return string[]
local function get_prop_names(id_node)
  local object_type_node = id_node:child(3)
  if object_type_node:type() ~= "object_type" then
    return {}
  end

  local prop_names = {}
  for prop_signature in object_type_node:iter_children() do
    if prop_signature:type() == "property_signature" then
      local prop_iden = prop_signature:child(0)
      local prop_name = vim.treesitter.get_node_text(prop_iden, 0)
      prop_names[#prop_names + 1] = prop_name
    end
  end

  return prop_names
end

return {
  snippet(
    {
      trig = "im",
      name = "import",
      dscr = "import a component/function from a package",
    },
    fmt([[import {name} from '{path}']], {
      path = insert_node(1),
      name = choice_node(2, {
        snippet_node(nil, { text_node("{ "), insert_node(1), text_node(" }") }),
        insert_node(nil),
      }),
    })
  ),
  snippet(
    { trig = "cl", name = "console.log", dscr = "Log a variable" },
    fmt('console.log("{}", {});', { insert_node(1), rep(1) })
  ),
  snippet(
    { trig = "console-callout", name = "Console callout", dscr = "Print something that will stand-out" },
    fmt(
      [[
          console.log('=============================');
          console.log("{}", {});
          console.log('=============================')
        ]],
      { insert_node(1), rep(1) }
    )
  ),
  snippet(
    { trig = "describe", name = "Vitest describe clause" },
    fmt(
      [[
          import {{describe, it}} from "vitest";

          describe("{}", () => {{
            it("should {}", () => {{}});
          }});
        ]],
      { insert_node(1), insert_node(2) }
    )
  ),
  snippet(
    { trig = "it", name = "Vitest test" },
    fmt(
      [[
          it("should {}", () => {{
            {}
          }});
        ]],
      { insert_node(1), insert_node(2) }
    )
  ),
  snippet(
    { trig = "af", name = "Anonymous function" },
    fmt(
      [[
          {}const {} = ({}) => {{
            {}
          }};
        ]],
      {
        choice_node(1, { text_node(""), text_node("export ") }),
        insert_node(2, { "functionName" }),
        insert_node(3),
        insert_node(4),
      }
    )
  ),
  snippet(
    { trig = "comp", desc = "React component Template", name = "React component template" },
    fmt(
      [[
	import React from 'react'

	export type {}Props = {{
	  {}
	}}

	export const {}: React.FC<{}Props> = ({{{}}}) => {{
	  return (
		<div>
		  {}
		</div>
	  );
	}};
	]],
      {
        -- Initialize component name to file name
        dynamic_node(1, function(_, snip) -- CompName
          local dirname = vim.fn.expand("%"):match("([^/]+)/[^/]+$")
          local filename = vim.fn.expand("%:t")
          if filename == "index.tsx" then
            return snippet_node(nil, {
              insert_node(1, dirname),
            })
          end

          return snippet_node(nil, {
            insert_node(1, vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
          })
        end),
        insert_node(2, "// Props"),
        rep(1),
        rep(1),
        function_node(function(_, snip, _)
          local parent = snip.nodes[3]
          if parent == nil or parent.mark == nil then
            return
          end
          local pos_begin = parent.mark:pos_begin()
          local pos_end = parent.mark:pos_end()
          local parser = vim.treesitter.get_parser(0, "tsx")
          local tstree = parser:parse()

          local node = tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

          if node == nil then
            return ""
          end

          local prop_names = get_prop_names(node)

          return vim.fn.join(prop_names, ", ")
        end, { 2 }), -- Pass in the node of the // Props as `snip`
        insert_node(3, "Hello, World!"),
      }
    )
  ),
  snippet(
    { trig = "story" },
    fmt(
      [[
import React from "react";
import type {{ Meta, StoryObj }} from "@storybook/react";

import {{ {} }} from "./{}";

const meta: Meta<typeof {}> = {{
  component: {},
  args: {{
  }},
}};
export default meta;

export const Default: StoryObj<typeof {}> = {{
  render: function Render(args) {{
    return (<{} />);
  }},
}};
      ]],
      { insert_node(1, { "Component" }), rep(1), rep(1), rep(1), rep(1), rep(1) }
    )
  ),
  snippet(
    { trig = "styled", name = "Styled component" },
    fmt(
      [[
const {} = styled.{}`
  {}
`;
      ]],
      {
        insert_node(1, { "Styled" }),
        insert_node(2, { "div" }),
        insert_node(3),
      }
    )
  ),
  snippet(
    { trig = "api", name = "API hook", desc = "API hook" },
    fmt(
      [[
import { useQuery } from "@tanstack/react-query";
import { AxiosInstance } from "axios";

import { useSomeClient } from "../apiClient";
import {
  SomeBody,
  SomeResponse,
  apiV1GetSomeUrl,
} from "../../../../generated/SomeApi";

export const _PATH = "/";

const fetchSomething = async (
  apiClient: AxiosInstance,
  body?: SomeBody
) => {
  const { data } = await apiClient.post<SomeResponse>(
    apiV1GetSomeUrl(
      apiClient.defaults.baseURL ?? ""
    ),
    body ?? {}
  );

  return data;
};

export const useGetSomething = (
  body?: SomeBody,
  options?: { enabled?: boolean }
) => {
  const apiClient = useSomeClient();
  return useQuery([_PATH, ], () => fetchSomething(apiClient, body), options);
};
  ]],
      {},
      { delimiters = "%$" }
    )
  ),
  snippet(
    { trig = "client", name = "API client", desc = "API client" },
    fmt(
      [[
      import axios from "axios";
      import { useMemo } from "react";

      import { getAppConfig } from "../../config/appConfig";
      import { useRequestHeaders } from "../common-api/headers";
      import { useReportAxiosError } from "../../../components/reliability/hooks/useReportAxiosError";

      const getWorkspacesAPIBasePath = (): string => {
      return getAppConfig().workspacesAPIServerURL;
    };

  export const useWorkspacesApiClient = () => {
    const headers = useRequestHeaders();
    const reportAxiosError = useReportAxiosError();

    const client = useMemo(
      () =>
      axios.create({
        baseURL: getWorkspacesAPIBasePath(),
        headers,
      }),
      [headers]
    );

    client.interceptors.response.use(undefined, (error) => {
      reportAxiosError(error);
      return Promise.reject(error);
    });

    return client;
  };
]],
      {},
      { delimiters = "%$" }
    )
  ),
  snippet(
    { trig = "use", name = "Custom hook", desc = "Custom hook" },
    fmt(
      [[
          export const use{} = () => {{
            {}
          }}
        ]],
      { insert_node(1), insert_node(2) }
    )
  ),
  snippet(
    {
      trig = "us",
      name = "useState",
      desc = "useState with type annotation",
    },
    fmt([[const [{state}, {setState}] = useState({initial_value})]], {
      state = insert_node(1),
      setState = function_node(function(args)
        if args[1][1]:len() > 0 then
          return "set" .. args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
        else
          return ""
        end
      end, 1),
      initial_value = insert_node(0),
    })
  ),
  snippet(
    {
      trig = "ue",
      name = "useEffect",
      desc = "useEffect",
    },
    fmt(
      [[
          useEffect(() => {{
            {body}
          }}, [{deps}])
        ]],
      {
        body = insert_node(1),
        deps = insert_node(2),
      }
    )
  ),
  snippet(
    {
      trig = "um",
      name = "useMemo",
      desc = "useMemo",
    },
    fmt(
      [[
          useMemo(() => {{
            {body}
          }}, [{deps}])
        ]],
      {
        body = insert_node(1),
        deps = insert_node(2),
      }
    )
  ),
  snippet(
    {
      trig = "uo",
      name = "useOverridableFlags",
      desc = "useOverridableFlags",
    },
    fmt(
      [[
          const { <> } = useOverridableFlags();
        ]],
      {
        insert_node(1),
      },
      { delimiters = "<>" }
    )
  ),
}
