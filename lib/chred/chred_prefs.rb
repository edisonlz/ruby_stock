module CHRED

  # Hash of configs/preferences.
  
  PREFS = Hash.new
  
  # Set the default preference values.
  def CHRED.init_prefs()
  
    PREFS['chred.width'] = 800
    PREFS['chred.height'] = 600
    
    
    PREFS['internet.type'] = 'direct'
    PREFS['internet.open_timeout'] = 5
    PREFS['internet.read_timeout'] = 5
  
    return PREFS
  end
  
end
