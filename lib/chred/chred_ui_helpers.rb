
module CHRED
 
  ##
  #初始化数据库
  def CHRED.init_mongoose_db( datapath=nil )
    
    path =  File.expand_path( File.dirname( __FILE__  ) + '/../database/' )
    puts  path
   
    db = Mongoose::Database.new( :path => path )
        
    # Initialize the Mongoose database.
    #PREFS['mdb'] = datapath.blank? ? db : Mongoose::Database.new( :path => datapath )
    PREFS['mdb'] = db
    StockInfo.ensure( PREFS['mdb'] )
    DayList.ensure( PREFS['mdb'] )
    StandList.ensure( PREFS['mdb'] )
    ExtendList.ensure( PREFS['mdb'] )
    RealTime.ensure( PREFS['mdb'] )
    
  end
  
end

