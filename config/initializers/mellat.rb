# Depricated wsdl https://pgwstest.bpm.bankmellat.ir/pgwchannel/services/pgw?wsdl moved to https://bpm.shaparak.ir/pgwchannel/services/pgw?wsdl
# More detail http://www.behpardakht.com/resources/files/PGW_Migration_User_Guide.pdf
Mellat.configure do |config|
	config.wsdl=''
	config.terminalId=''
	config.userName=''
	config.userPassword=''
	# steam account
	# you can use steam cloud for record any transaction
	config.steam = true;
	config.steam_username = ''
	config.steam_password = ''
	# log
	config.log_path = '';
	config.log_level = '';
	config.log_type = '';
end