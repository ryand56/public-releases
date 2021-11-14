-- // 3D Box ESP                                                                                                    // --
-- // Made by elementemerald#4175                                                                                   // --
-- // Library by Blissful#4992 (https://v3rmillion.net/showthread.php?tid=1143560), modified by elementemerald#4175 // --

local Library = {};

local Camera = workspace.CurrentCamera;
local ToScreen = Camera.WorldToViewportPoint;

local RS = game:GetService("RunService");

local nVector3 = Vector3.new;
local nVector2 = Vector2.new;
local nDrawing = Drawing.new;
local nColor   = Color3.fromRGB;
local nCFrame = CFrame.new;
local nCFAngles = CFrame.Angles;

local rad = math.rad;
local pi = math.pi;
local round = math.round;

local Insert = table.insert;
local Char = string.char;
local Random = math.random;
local Seed = math.randomseed;
local Time = os.time;

local charset = {};

for i = 48,  57 do Insert(charset, Char(i)) end;
for i = 65,  90 do Insert(charset, Char(i)) end;
for i = 97, 122 do Insert(charset, Char(i)) end;

local function random_string(length)
    Seed(Time());

    if length > 0 then
        return random_string(length - 1) .. charset[Random(1, #charset)];
    else
        return "";
    end;
end;

local function checkCamView(pos)
    return ((pos - Camera.CFrame.Position).Unit):Dot(Camera.CFrame.LookVector) > 0;
end

function Library:New3DLine()
    local _line = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        From         = nVector3(0,0,0);
        To           = nVector3(0,0,0);
    };
    local _defaults = _line;
    _line.line = nDrawing("Line");

    -- Update Step Function --
    function _line:Update()
        if not _line.Visible then
            _line.line.Visible = false;
        else
            _line.line.Visible      = _line.Visible      or _defaults.Visible;
            _line.line.ZIndex       = _line.ZIndex       or _defaults.ZIndex;
            _line.line.Transparency = _line.Transparency or _defaults.Transparency;
            _line.line.Color        = _line.Color        or _defaults.Color;
            _line.line.Thickness    = _line.Thickness    or _defaults.Thickness;

            local _from, v1 = ToScreen(Camera, _line.From);
            local _to,   v2 = ToScreen(Camera, _line.To);

            if (v1 and v2) or (checkCamView(_line.From) and checkCamView(_line.To)) then
                _line.line.From = nVector2(_from.x, _from.y);
                _line.line.To   = nVector2(_to.x, _to.y);
            else
                _line.line.Visible = false;
            end;
        end
    end;
    --------------------------

    local step_Id = "3D_Line"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _line.Update);

    -- Remove Line --
    function _line:Remove()
        RS:UnbindFromRenderStep(step_Id);

        self.line:Remove();
    end;
    -----------------

    return _line;
end;

function Library:New3DCube()
    local _cube = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        Filled       = true;
        
        Position     = nVector3(0,0,0);
        Size         = nVector3(0,0,0);
        Rotation     = nVector3(0,0,0);
    };
    local _defaults  = _cube;
    for f = 1, 6 do
        _cube["face"..tostring(f)] = nDrawing("Quad");
    end;

    local step_Id = "3D_Cube"..random_string(10);

    -- Remove Cube --
    function _cube:Remove()
        for f = 1, 6 do
            self["face"..tostring(f)]:Remove();
        end;
    end;
    -----------------

    return _cube;
end;

function Library:New3DSquare()
    local _square = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        Filled       = true;
        
        Position     = nVector3(0,0,0);
        Size         = nVector2(0,0);
        Rotation     = nVector3(0,0,0);
    }
    local _defaults = _square;
    _square.square = nDrawing("Quad");

    -- Update Step Function --
    function _square:Update()
        if not _square.Visible then 
            _square.square.Visible = false;
        else
            _square.square.Visible      = _square.Visible      or _defaults.Visible;
            _square.square.ZIndex       = _square.ZIndex       or _defaults.ZIndex;
            _square.square.Transparency = _square.Transparency or _defaults.Transparency;
            _square.square.Color        = _square.Color        or _defaults.Color;
            _square.square.Thickness    = _square.Thickness    or _defaults.Thickness;
            _square.square.Filled       = _square.Filled       or _defaults.Filled;

            local rot = _square.Rotation or _defaults.Rotation;
            local pos = _square.Position or _defaults.Position;
            local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), rad(rot.Y), rad(rot.Z));

            local _size = _square.Size or _defaults.Size;
            local _points = {
                [1] = (_rotCFrame * nCFrame(_size.X, 0, _size.Y)).p;
                [2] = (_rotCFrame * nCFrame(_size.X, 0, -_size.Y)).p;
                [3] = (_rotCFrame * nCFrame(-_size.X, 0, _size.Y)).p;
                [4] = (_rotCFrame * nCFrame(-_size.X, 0, -_size.Y)).p;
            };

            local _vis = true;

            for p = 1, #_points do
                local _p, v = ToScreen(Camera, _points[p]);
                local _stored = _points[p];
                _points[p] = nVector2(_p.x, _p.y);

                if not v and not checkCamView(_stored) then 
                    _vis = false;
                    break;
                end;
            end;

            if _vis then
                _square.square.PointA = _points[1];
                _square.square.PointB = _points[2];
                _square.square.PointC = _points[4];
                _square.square.PointD = _points[3];
            else
                _square.square.Visible = false;
            end;
        end;
    end;
    --------------------------

    local step_Id = "3D_Square"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _square.Update);

    -- Remove Square --
    function _square:Remove()
        RS:UnbindFromRenderStep(step_Id);

        _square.square:Remove();
    end;
    -----------------

    return _square;
end;

function Library:New3DCircle()
    local _circle = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        
        Position     = nVector3(0,0,0);
        Radius       = 10;
        Rotation     = nVector2(0,0);
    };
    local _defaults = _circle;
    local _lines = {};

    local function makeNewLines(r)
        for l = 1, #_lines do
            _lines[l]:Remove();
        end;

        _lines = {};
        
        for l = 1, 1.5*r*pi do
            _lines[l] = nDrawing("Line");
        end;
    end;

    -- Update Step Function --
    local previousR = _circle.Radius or _defaults.Radius;
    makeNewLines(previousR);

    function _circle:Update()
        local rot = _circle.Rotation or _defaults.Rotation;
        local pos = _circle.Position or _defaults.Position;
        local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), 0, rad(rot.Y));

        local _radius = _circle.Radius or _defaults.Radius;
        if previousR ~= _radius then makeNewLines(_radius) end;

        local _increm = 360/#_lines;

        if not _circle.Visible then 
            for ln = 1, #_lines do
                _lines[ln].Visible = false;
            end;
        else
            for l = 1, #_lines do
                if _lines[l] and rawget(_lines[l], "__OBJECT_EXISTS") then
                    _lines[l].Visible      = _circle.Visible      or _defaults.Visible;
                    _lines[l].ZIndex       = _circle.ZIndex       or _defaults.ZIndex;
                    _lines[l].Transparency = _circle.Transparency or _defaults.Transparency;
                    _lines[l].Color        = _circle.Color        or _defaults.Color;
                    _lines[l].Thickness    = _circle.Thickness    or _defaults.Thickness;

                    local p1 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _previousPosition, v1 = ToScreen(Camera, p1);

                    _rotCFrame = _rotCFrame * nCFAngles(0, rad(_increm), 0);

                    local p2 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _nextPosition, v2 = ToScreen(Camera, p2);

                    if (v1 and v2) or (checkCamView(p1) and checkCamView(p2)) then
                        _lines[l].From = nVector2(_previousPosition.x, _previousPosition.y);
                        _lines[l].To = nVector2(_nextPosition.x, _nextPosition.y);
                    else
                        _lines[l].Visible = false;
                    end;
                end;
            end;
        end;

        previousR = _circle.Radius or _defaults.Radius;
    end;
    --------------------------

    local step_Id = "3D_Circle"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _circle.Update);

    -- Remove Circle --
    function _circle:Remove()
        RS:UnbindFromRenderStep(step_Id)

        for ln = 1, #_lines do
            _lines[ln]:Remove();
        end;
    end;
    -----------------

    return _circle;
end;

------------------------------------------------------

local ESP = {
	Enabled = false,
	TeamColor = true,
	DefaultColor = Color3.fromRGB(255, 255, 255)
};

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local RunService = game:GetService("RunService");

local ESPStorage = {
	Players = {},
	CharAddedEventStorage = {}
};

local function createESPBox(Character)
	if Character and typeof(Character) == "Instance" and Character.ClassName == "Model" then
		local HRP = Character:FindFirstChild("HumanoidRootPart");
		local Head = Character:FindFirstChild("Head");
		if HRP ~= nil and Head ~= nil then
			local Player = Players:GetPlayerFromCharacter(Character);
			
			if Player ~= nil then
				local Cube = Library:New3DCube();
				Cube.Visible = true;
				Cube.ZIndex = 1;
				Cube.Transparency = 0.3;
				Cube.Color = ESP.TeamColor and Player.TeamColor.Color or ESP.DefaultColor;
				Cube.Thickness = 3;
				Cube.Filled = true;
				
				Cube.Size = HRP.Size;
				
				ESPStorage.Players[Player.UserId].Cube = Cube;
				
				Character.AncestryChanged:Connect(function(_, parent)
					if parent == nil then
						if ESPStorage.Players[Player.UserId].Cube ~= nil then
							ESPStorage.Players[Player.UserId].Cube:Remove();
							ESPStorage.Players[Player.UserId].Cube = nil;
						end;
					end;
				end);
				
				Character:GetPropertyChangedSignal("Parent"):Connect(function()
					if Character.Parent == nil then
						if ESPStorage.Players[Player.UserId].Cube ~= nil then
							ESPStorage.Players[Player.UserId].Cube:Remove();
							ESPStorage.Players[Player.UserId].Cube = nil;
						end;
					end;
				end);
				
				local Humanoid = Character:FindFirstChildOfClass("Humanoid");
				if Humanoid ~= nil then
					Humanoid.Died:Connect(function()
						if ESPStorage.Players[Player.UserId].Cube ~= nil then
							ESPStorage.Players[Player.UserId].Cube:Remove();
							ESPStorage.Players[Player.UserId].Cube = nil;
						end;
					end);
				end;
			end;
		end;
	end;
end;

Players.PlayerAdded:Connect(function(Player)
	if ESP.Enabled then
		if Player ~= LocalPlayer then
			if ESPStorage.Players[Player.UserId] == nil then
				ESPStorage.Players[Player.UserId] = {};
			end;
			
			if ESPStorage.CharAddedEventStorage[Player.UserId] == nil then
				ESPStorage.CharAddedEventStorage[Player.UserId] = Player.CharacterAdded:Connect(function(Character)
					ESPStorage.Players[Player.UserId].Character = Character;
					
					repeat task.wait() until Character:FindFirstChild("HumanoidRootPart");
					repeat task.wait() until Character:FindFirstChild("Head");
					
					createESPBox(Character);
				end);
				
				createESPBox(Player.Character);
			end;
		end;
	end;
end);

Players.PlayerRemoving:Connect(function(Player)
	if ESP.Enabled then
		if typeof(ESPStorage.CharAddedEventStorage[Player.UserId]) == "RBXScriptConnection" then
			ESPStorage.CharAddedEventStorage[Player.UserId]:Disconnect();
			ESPStorage.CharAddedEventStorage[Player.UserId] = nil;
		end;
		if ESPStorage.Players[Player.UserId].Cube ~= nil then
			pcall(function()
				ESPStorage.Players[Player.UserId].Cube:Remove();
				ESPStorage.Players[Player.UserId].Cube = nil;
			end);
		end;
		ESPStorage.Players[Player.UserId] = nil;
	end;
end);

RunService:BindToRenderStep("UpdateESP", Enum.RenderPriority.Character.Value, function()
	if ESP.Enabled then
		for _, ESP in next, ESPStorage.Players do
			if ESP.Cube ~= nil then
				local Character = ESP.Character;
				
				if Character ~= nil then
					local Player = Players:GetPlayerFromCharacter(Character);
					
					local HRP = Character:FindFirstChild("HumanoidRootPart");
					local Head = Character:FindFirstChild("Head");
					
					if Player ~= nil and HRP ~= nil and Head ~= nil then
						local _cube = {
							Visible      = false;
							ZIndex       = 1;
							Transparency = 1;
							Color        = ESP.DefaultColor;
							Thickness    = 1;
							Filled       = true;
							
							Position     = nVector3(0,0,0);
							Size         = nVector3(0,0,0);
							Rotation     = nVector3(0,0,0);
						};
						local _defaults  = _cube;
						
						if not ESP.Cube.Visible then
							for f = 1, 6 do
								ESP.Cube["face"..tostring(f)].Visible = false;
							end;
						else
							for f = 1, 6 do
								f = "face"..tostring(f)
								ESP.Cube[f].Visible      = ESP.Cube.Visible      or _defaults.Visible;
								ESP.Cube[f].ZIndex       = ESP.Cube.ZIndex       or _defaults.ZIndex;
								ESP.Cube[f].Transparency = ESP.Cube.Transparency or _defaults.Transparency;
								ESP.Cube[f].Color        = ESP.Cube.Color        or _defaults.Color;
								ESP.Cube[f].Thickness    = ESP.Cube.Thickness    or _defaults.Thickness;
								ESP.Cube[f].Filled       = ESP.Cube.Filled       or _defaults.Filled;
							end;

							local rot = ESP.Cube.Rotation or _defaults.Rotation;
							local pos = HRP.Position or _defaults.Position;
							local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), rad(rot.Y), rad(rot.Z));

							local _size = ESP.Cube.Size or _defaults.Size;
							local _points = {
								[1] = (_rotCFrame * nCFrame(_size.X, _size.Y, _size.Z)).p;
								[2] = (_rotCFrame * nCFrame(_size.X, _size.Y, -_size.Z)).p;
								[3] = (_rotCFrame * nCFrame(_size.X, -_size.Y, _size.Z)).p;
								[4] = (_rotCFrame * nCFrame(_size.X, -_size.Y, -_size.Z)).p;
								[5] = (_rotCFrame * nCFrame(-_size.X, _size.Y, _size.Z)).p;
								[6] = (_rotCFrame * nCFrame(-_size.X, _size.Y, -_size.Z)).p;
								[7] = (_rotCFrame * nCFrame(-_size.X, -_size.Y, _size.Z)).p;
								[8] = (_rotCFrame * nCFrame(-_size.X, -_size.Y, -_size.Z)).p;
							};

							local _vis = true;

							for p = 1, #_points do
								local _p, v = ToScreen(Camera, _points[p]);
								local _stored = _points[p];
								_points[p] = nVector2(_p.x, _p.y);

								if not v and not checkCamView(_stored) then 
									_vis = false;
									break;
								end;
							end;

							if _vis then
								ESP.Cube.face1.PointA = _points[1]; -- Side
								ESP.Cube.face1.PointB = _points[2];
								ESP.Cube.face1.PointC = _points[4];
								ESP.Cube.face1.PointD = _points[3];

								ESP.Cube.face2.PointA = _points[5]; -- Side
								ESP.Cube.face2.PointB = _points[6];
								ESP.Cube.face2.PointC = _points[8];
								ESP.Cube.face2.PointD = _points[7];

								ESP.Cube.face3.PointA = _points[1]; -- Side
								ESP.Cube.face3.PointB = _points[5];
								ESP.Cube.face3.PointC = _points[7];
								ESP.Cube.face3.PointD = _points[3];

								ESP.Cube.face4.PointA = _points[2]; -- Side
								ESP.Cube.face4.PointB = _points[4];
								ESP.Cube.face4.PointC = _points[8];
								ESP.Cube.face4.PointD = _points[6];

								ESP.Cube.face5.PointA = _points[1]; -- Top
								ESP.Cube.face5.PointB = _points[2];
								ESP.Cube.face5.PointC = _points[6];
								ESP.Cube.face5.PointD = _points[5];

								ESP.Cube.face6.PointA = _points[3]; -- Bottom
								ESP.Cube.face6.PointB = _points[4];
								ESP.Cube.face6.PointC = _points[8];
								ESP.Cube.face6.PointD = _points[7];
							else
								for f = 1, 6 do
									ESP.Cube["face"..tostring(f)].Visible = false;
								end;
							end;
						end;
						
						ESP.Cube.Color = ESP.TeamColor and Player.TeamColor.Color or ESP.DefaultColor;
					end;
				end;
			end;
		end;
	end;
end);

function ESP:Toggle()
	ESP.Enabled = not ESP.Enabled;
	if ESP.Enabled then
		for _, Player in next, Players:GetPlayers() do
			if Player ~= LocalPlayer and Player.Character ~= nil then
				if ESPStorage.Players[Player.UserId] == nil then
					ESPStorage.Players[Player.UserId] = {
						["Character"] = Player.Character
					};
				end;
				
				if ESPStorage.CharAddedEventStorage[Player.UserId] == nil then
					ESPStorage.CharAddedEventStorage[Player.UserId] = Player.CharacterAdded:Connect(function(Character)
						ESPStorage.Players[Player.UserId].Character = Character;
						
						repeat task.wait() until Character:FindFirstChild("HumanoidRootPart");
						repeat task.wait() until Character:FindFirstChild("Head");
						
						createESPBox(Character);
					end);
					
					createESPBox(Player.Character);
				end;
			end;
		end;
	else
		for _, Player in next, Players:GetPlayers() do
			if ESPStorage.Players[Player.UserId] ~= nil then
				if ESPStorage.Players[Player.UserId].Cube ~= nil then
					ESPStorage.Players[Player.UserId].Cube:Remove();
					ESPStorage.Players[Player.UserId].Cube = nil;
				end;
				
				ESPStorage.Players[Player.UserId] = nil;
			end;
			
			if typeof(ESPStorage.CharAddedEventStorage[Player.UserId]) == "RBXScriptConnection" then
				ESPStorage.CharAddedEventStorage[Player.UserId]:Disconnect();
				ESPStorage.CharAddedEventStorage[Player.UserId] = nil;
			end;
		end;
	end;
end;

function ESP:ToggleTeam()
	ESP.TeamColor = not ESP.TeamColor;
end;

function ESP:SetDefaultColor(Color)
	if typeof(Color) == "Color3" then
		ESP.DefaultColor = Color;
	end;
end;

return ESP;