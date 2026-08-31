-- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=Your%20Momlocal
M = {}

M.headers = {
    { [[
                       ,,                    
                       db                    
                                             
`7MMpMMMb.`7M'   `MF'`7MM  `7MMpMMMb.pMMMb.  
  MM    MM  VA   ,V    MM    MM    MM    MM  
  MM    MM   VA ,V     MM    MM    MM    MM  
  MM    MM    VVV      MM    MM    MM    MM  
.JMML  JMML.   W     .JMML..JMML  JMML  JMML.
	]], },
}

M.random_header = function()
    math.randomseed(os.time())
    return table.concat(M.headers[math.random(#M.headers)], "\n")
end

return M
