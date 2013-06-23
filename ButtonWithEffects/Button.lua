Button = 
{   
    parent            = nil,
    layer             = nil,
    posX              = nil,
    posY              = nil,
    width             = nil,
    height            = nil,
    isActive          = false,
    inactiveImgSrc    = nil,
    activeImgSrc      = nil,
    maskImgSrc        = nil,
    inactiveImg       = nil,
    activeImg         = nil,
    maskImg           = nil,
    callbackArgs      = nil,
    onPressCallback   = nil,
    onReleaseCallback = nil
}


function Button:newButton( inactiveImgSrc, posX, posY, width, height, parent )

    -- initial a button object

    local buttonObject = {}
    setmetatable(buttonObject, self)
    self.__index = self

    buttonObject.inactiveImgSrc = inactiveImgSrc
    buttonObject.activeImgSrc = "pressed"..inactiveImgSrc
    buttonObject.posX = posX
    buttonObject.posY = posY
    buttonObject.width = width
    buttonObject.height = height
    buttonObject.parent = parent

    return buttonObject

end

function Button:setCallback( callback, callbackArgs )
    self.onReleaseCallback = callback
    self.callbackArgs = callbackArgs
end

function Button:setSoundEffect( soundSrc )
    -- body
end

function Button:show( )

    self.layer = display.newGroup()
    self.layer.x = self.posX
    self.layer.y = self.posY
    self.layer:addEventListener("touch", self)
    self.parent:insert(self.layer)

    self.inactiveImg = display.newImageRect(self.layer, self.inactiveImgSrc, self.width, self.height)
end


function Button:touch( event )

    local target = event.target
    local phase  = event.phase
    print("touching")
    if phase == "began" then
        target.isFocus = true
        display.getCurrentStage():setFocus( target )

        local soundEffect = audio.loadSound("click_button.mp3")
        audio.play( soundEffect )  

        if not self.activeImg then 
            self.activeImg = display.newImageRect(self.layer, self.inactiveImgSrc, self.width, self.height)
        else
            self.activeImg.isVisible = true
        end


    elseif target.isFocus then
        
        -- check if the touch is out of the button's range
        local bounds = target.contentBounds
        local touchX, touchY = event.x, event.y
        local isWithinBounds =  bounds.xMin <= touchX and bounds.xMax >= touchX and bounds.yMin <= touchY and bounds.yMax >= touchY

        if phase == "moved" then
            print("phase == moved ")

            if  isWithinBounds then
                print("isWithinBounds")
                self.activeImg.isVisible = true
            else 
                print("not isWithinBounds")
                self.activeImg.isVisible = false
            end


        elseif phase == "ended" or phase == "cancelled" then

            --clear the visual effect 

            if phase == "ended" then

                if isWithinBounds then
                    if self.onReleaseCallback then
                        print("onReleaseCallback")
                        self.onReleaseCallback(self.callbackArgs["callbackHost"])
                    else

                    end

                end
            end

            self.activeImg.isVisible = false
            display.getCurrentStage():setFocus( nil )
            target.isFocus = false

        end
    else
         self.activeImg.isVisible = false
    end
    return true
end




