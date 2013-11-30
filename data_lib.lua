--[[
money 2.01

Removed the value getting/setting routines from
the original code, in order to do some changes.
This way, we reduce the amount of money files.
]]

local user_table = {}

function money.get( name )
	if #user_table == 0 then
		freeminer.log( 'error', 'money] Could not access user_table' )
		return nil
	end
	if user_table[name] then
		return user_table[name]
	end
	return false
end

function money.set( name, value )
	if #user_table == 0 then
		freeminer.log( 'error', 'money] Could not access user_table [2]' )
		return nil
	end
	user_table[name] = value
	save_file = io.open( freeminer.get_worldpath()..package.config:sub(1,1)..'money', 'w' )
	if not save_file then
		freeminer.log( 'error' , 'money] Could not open money file' )
		return nil
	end
	save_file:write( freeminer.serialize( user_table ) )
	io.close( save_file )
	return true
end

function money.init_utable( )
	money_file = io.open( freeminer.get_worldpath()..package.config:sub(1,1)..'money', 'r' )
	if not money_file then
		freeminer.log( 'error', 'money] Could not open money file' )
		return nil
	end
	data = money_file:read( '*all' )
	user_table = freeminer.deserialize( data )
	if type( user_table ) ~= type( {} ) then
		freeminer.log( 'debug' , 'money] user_table matches not expected format' )
		return false
	end
	return true
end

