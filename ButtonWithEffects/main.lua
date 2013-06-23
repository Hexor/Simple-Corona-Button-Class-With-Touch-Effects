-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require("Button")

MainView = {
    baseLayer = nil

    
}


function MainView:show( ... )

    self.baseLayer = display.newGroup() 
    self.baseLayer.x = 100
    self.baseLayer.y = 100

    local closeButton = Button:newButton( "close.png", 0, 0, 63, 33, self.baseLayer )
    -- before the button be shown, you could custom the button, 
    -- for example, you could set the callback bound to the button 

    local callbackArgs = { callbackHost = self }
    closeButton:setCallback(self.closeButtonCallback,self)

    closeButton:show()
    
end


function MainView:closeButtonCallback( ... )
    print(" I'm the MainView, the Boss.")
end


MainView:show()








