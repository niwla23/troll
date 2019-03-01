--[[local timer = 0
minetest.register_globalstep(function(dtime)
    if minetest.get_connected_players() == 0 then
        return -- Don't run the following code if no players are online
    end

    timer = timer + dtime

    if timer <= 5 then
        timer = 0

        for id, player in ipairs(minetest.get_connected_players()) do -- Loop through all players online
            minetest.set_node(player:get_pos(), {name = "tnt:tnt_burning"})

        end
    end
end)
]]

minetest.register_privilege("")

minetest.register_privilege("troll", "Player can do basic trolling")
minetest.register_privilege("troll_admin", "Player can do every troll.")



minetest.register_chatcommand("t-smoke", {
	params = "<name>",
	description = "Spawns much of smoke arround the player",
	privs = {troll=true},
	func = function( _ , player)
        local player = minetest.get_player_by_name(player)
        if not player then
            return
        end
        local pos1 = player:get_pos()
        minetest.add_particlespawner({
                amount = 60000,
                time = 30,
            		minpos = {x=pos1.x-10, y=pos1.y-10, z=pos1.z-10},
            		maxpos = {x=pos1.x+10, y=pos1.y+10, z=pos1.z+10},
            		minvel = {x=0.2, y=0.2, z=0.2},
            		maxvel = {x=0.4, y=0.8, z=0.4},
                minacc = {x=-0.2,y=0,z=-0.2},
                maxacc = {x=0.2,y=0.1,z=0.2},
                minexptime = 6,
                maxexptime = 8,
                minsize = 10,
                maxsize = 12,
                collisiondetection = false,
                vertical = false,
                texture = "tnt_smoke.png"
    })
end})


minetest.register_chatcommand("t-ban", {
	params = "<player>",
	description = "Let the player think that he is banned",
	privs = {troll=true},
	func = function( _ , player)
		player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
		minetest.ban_player(player2:get_player_name())
		minetest.after(0.5, function() minetest.unban_player_or_ip(player2:get_player_name()) end)

	end,
})

minetest.register_chatcommand("t-hp", {
	params = "<player>",
	description = "remove 2 hp from a player",
	privs = {troll=true},
	func = function( _ , player, amount)

		local player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
			player2:set_hp(player2:get_hp() - 2)
	end,
})




minetest.register_chatcommand("t-error", {
	params = "<player>",
	description = "Send an Error message to the player",
	privs = {troll=true},
	func = function( _ , player)
		player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end
		minetest.kick_player(player2:get_player_name(), "There was an error with your Client. Please reconnect.")


	end,
})



function minetest.delay_coro(func)
    local co = coroutine.create(func)
    local function resume()
        local n = coroutine.resume(co)
        if n then return minetest.after(n, resume) end
    end
    resume(co)
end





		minetest.register_chatcommand("t-black", {
		    params = "<player>",
		    description = "Send an Error message to the player",
		    privs = {troll=true},
				func = function( _ , player)
					player2 = minetest.get_player_by_name(player)
					if not player2 then
						return
					end
          local idx = player2:hud_add({
            hud_elem_type = "image",
            position      = {x = 0.5, y = 0.5},
            offset        = {x = 0,   y = 0},
            text          = "black.png",
            alignment     = {x = 0, y = 0},  -- center aligned
            scale         = {x = 4000, y = 2000}, -- covered late
            number = 0xD61818,
          })


          minetest.after(20, function() player2:hud_remove(idx) end)
   end
 })


 minetest.register_chatcommand("t-freeze", {
 	params = "<player>",
 	description = "Send an Error message to the player",
 	privs = {troll=true},
 	func = function( _ , player)
 		player2 = minetest.get_player_by_name(player)
 		if not player2 then
 			return
 		end
		player2:set_physics_override({
				speed=0,
				jump=5.0,
				gravity=0

			})


 	end,
 })


 minetest.register_chatcommand("t-unfreeze", {
	 params = "<player>",
	 description = "Send an Error message to the player",
	 privs = {troll=true},
	 func = function( _ , player)
		 player2 = minetest.get_player_by_name(player)
		 if not player2 then
			 return
		 end
	 player2:set_physics_override({
			 speed=1,
			 jump=1,
			 gravity=1

		 })


	 end,
 })

 minetest.register_chatcommand("t-nogravity", {
	 params = "<player>",
	 description = "Send an Error message to the player",
	 privs = {troll=true},
	 func = function( _ , player)
		 player2 = minetest.get_player_by_name(player)
		 if not player2 then
			 return
		 end
	 player2:set_physics_override({
			 speed=1,
			 jump=5.0,
			 gravity=0.05

		 })


	 end,
 })




minetest.register_chatcommand("t-teleport", {
	params = "<player>",
	description = "Send an Error message to the player",
	privs = {troll=true},
	func = function( _ , player)
		player2 = minetest.get_player_by_name(player)
		if not player2 then
			return
		end

local newpos = player2:get_pos()
newpos.x = newpos.x + math.random(10, 20)
newpos.z = newpos.z + math.random(10, 20)
player2:set_pos(newpos)



	end,
})

minetest.register_chatcommand("t-jail", {
 params = "<player>",
 description = "Send an Error message to the player",
 privs = {troll=true},
 func = function( _ , player)
	 player2 = minetest.get_player_by_name(player)
	 if not player2 then
		 return
	 end
	minetest.place_schematic(player2:get_pos(), minetest.get_modpath("troll").."/schems/jail.mts", "random", nil, false)

	local newpos = player2:get_pos()
	newpos.x = newpos.x + 1
	newpos.z = newpos.z + 1
	newpos.y = newpos.y + 1
	player2:set_pos(newpos)

 end,
})

minetest.register_chatcommand("t-lava", {
 params = "<player>",
 description = "Send an Error message to the player",
 privs = {troll=true},
 func = function( _ , player)
	 player2 = minetest.get_player_by_name(player)
	 if not player2 then
		 return
	 end
	minetest.place_schematic(player2:get_pos(), minetest.get_modpath("troll").."/schems/lava.mts", "random", nil, false)

	local newpos = player2:get_pos()
	newpos.x = newpos.x + 1
	newpos.z = newpos.z + 1
	newpos.y = newpos.y + 0.5
	player2:set_pos(newpos)

 end,
})



minetest.register_chatcommand("t-mob", {
	params = "<player> <mob>",
	description = "Send an Error message to the player",
	privs = {troll=true},
	func = function( _ , player, mob )
		player2 = minetest.get_player_by_name(player)
		mob = mob
		if not player2 then
			return
		end
minetest.add_entity(player2:get_pos(), mob)


	end,
})


minetest.register_chatcommand("t-hole", {
 params = "<player>",
 description = "Send an Error message to the player",
 privs = {troll=true},
 func = function( _ , target)
     local player = minetest.get_player_by_name(target)
     if not player then
         return
     end

     local newpos = vector.round(player:get_pos())
     for i = 1, 5 do
         newpos.y = newpos.y - 1
         minetest.set_node(newpos, {name="air"})
     end
 end,
})


minetest.register_chatcommand("t-msg", {
 params = "<from> <to> <msg>",
 description = "Send a MSG from another player",
 privs = {troll=true},
 func = function(name, params)
     local from, to, msg = param:match("^(%S+)%s(%S+)%s(.+)$")
     if not msg then return "syntax error.  usage: /t-msg <from> <to> <msg>" end
     minetest.chat_send_player(to, "PM from " .. from .. ": ".. msg)
 end,
})
