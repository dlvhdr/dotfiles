#!/bin/bash

function pidwait {
   pid=$1
   echo "PID: ${pid}"
   kill_res=$(kill -0 "${pid}")
   msg="${pid} not completed. Sleeping.."
   while [ $? -eq 0 ]
   do
      msg="${msg}."
      echo -en "\r${msg}"
      sleep 1
      kill_res=$(kill -0 "${pid}")
   done

   echo "${pid} completed!"
}

pidwait $1
