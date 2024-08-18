local plrs = game:GetService("Players")
local rservice = game:GetService("RunService")
local lplr = plrs.LocalPlayer
local char = lplr.Character
local hum = char:FindFirstChildOfClass("Humanoid")
local cam = workspace.CurrentCamera
Player = lplr
Character = char
Humanoid = hum

local function removeJoints(rig)
    rig = rig or "R6"
    if rig == "R6" then
        char.Torso:FindFirstChild("Right Shoulder"):Destroy()
        char.Torso:FindFirstChild("Left Shoulder"):Destroy()
        char.Torso:FindFirstChild("Right Hip"):Destroy()
        char.Torso:FindFirstChild("Left Hip"):Destroy()
        char.HumanoidRootPart:FindFirstChild("RootJoint"):Destroy()
    else

    end
end

char.Animate.Disabled = true
if hum.RigType == Enum.HumanoidRigType.R6 then
    removeJoints("R6")
end

local rig = char:Clone()
rig.Parent = char
rig.Name = "Reanimation Rig"
rig.HumanoidRootPart.Anchored = false
cam.CameraSubject = rig
rig.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame

function cf(p,rp)
    p.Velocity = Vector3.new(0,30,0)
    p.CFrame = rp.CFrame
end

collisions = rservice.Stepped:Connect(function()
    for i,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end)

cframeloop = rservice.Heartbeat:Connect(function()
    if not rig then cframeloop:Disconnect() collisions:Disconnect() return end
    rig.Humanoid.Jump = hum.Jump
    rig.Humanoid:Move(hum.MoveDirection)
    cf(char.Torso, rig.Torso)
    cf(char["Left Arm"], rig["Left Arm"])
    cf(char["Right Arm"], rig["Right Arm"])
    cf(char["Left Leg"], rig["Left Leg"])
    cf(char["Right Leg"], rig["Right Leg"])
end)

canim = char.Animate:Clone()
canim.Parent = rig
canim.Disabled = false