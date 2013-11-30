--[[
money 2.01

Removed the value getting/setting routines from
the original code, in order to do some changes.
This way, we reduce the amount of money files.
]]

local user_table = {}

local sep = money.sep

function money.get( name )
	if user_table[name] then
		return user_table[name]
	end
	return nil
end

function money.set( name, value )
	user_table[name] = value
	save_file = io.open( freeminer.get_worldpath()..sep..'money', 'w' )
	if not save_file then
		freeminer.log( 'error' , 'money] Could not open money file' )
		return nil
	end
	save_file:write( freeminer.serialize( user_table ) )
	io.close( save_file )
	return true
end

function money.init_utable( )
	money_file = io.open( freeminer.get_worldpath()..sep..'money', 'r' )
	if not money_file then
		user_table = {}
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

