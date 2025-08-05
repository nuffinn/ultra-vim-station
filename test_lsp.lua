-- Simple test file to verify LSP functionality
local function test_function()
  print("Hello, World!")
end

-- Call the function
test_function()

-- This should work with:
-- gd - Go to definition (should go to line 2)
-- gr - Find references (should show usage on line 8)
-- K - Show hover documentation
