

module CHRED

  DEFAUTLCODE="600000"
  DEFAULTPSSE="ss"
  DEFAULTSHOWCOUNT=180
  
  def CHRED.format(code=DEFAUTLCODE,suffix=DEFAULTPSSE)
    return "#{code}.#{suffix}"
  end

end
