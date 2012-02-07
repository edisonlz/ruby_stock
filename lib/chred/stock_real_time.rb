
module CHRED


  ##
  #先从数据库中找
  #在从接口读入数据
  #保存至数据库
  #返回数据列表
  def CHRED.get_real(symbols)
     puts "yahoo get real time #{symbols}"
    YahooFinance::get_realtime_quotes( symbols )
  end
  
end