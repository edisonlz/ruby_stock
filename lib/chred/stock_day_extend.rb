
module CHRED


  ##
  #先从数据库中找
  #在从接口读入数据
  #保存至数据库
  #返回数据列表
  def CHRED.get_extend(symbols)
    #从数据库中找
    #puts "yahoo get extend #{symbols}"
    YahooFinance::get_extended_quotes( symbols )
  end
  
end