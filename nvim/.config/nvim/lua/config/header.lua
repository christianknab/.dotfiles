-- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=Your%20Momlocal
M = {}

M.headers = {
    { [[
  ▗▄▄▖▐▌    ▄▄▄ ▄  ▄▄▄  ■  ▄ ▗▞▀▜▌▄▄▄▄  
 ▐▌   ▐▌   █    ▄ ▀▄▄▗▄▟▙▄▖▄ ▝▚▄▟▌█   █ 
 ▐▌   ▐▛▀▚▖█    █ ▄▄▄▀ ▐▌  █      █   █ 
 ▝▚▄▄▖▐▌ ▐▌     █      ▐▌  █            
                       ▐▌               
	]], },
}

M.random_header = function()
    math.randomseed(os.time())
    return table.concat(M.headers[math.random(#M.headers)], "\n")
end

return M
