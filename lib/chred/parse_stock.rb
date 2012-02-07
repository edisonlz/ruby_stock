
require "open-uri"

##
#parse 股票数据
class ParseStock
  
  ##
  #声明为单间模型
  #include Singleton

  ##
  #获得公司描述
  def desc(stock_code=600000)

    g=open("http://finance.google.com.cn/finance?client=ob&q=SHA:#{stock_code}")
    s=g.read

    reg=Regexp.new('<div class="item companySummary">[^<>]*</div>',Regexp::MULTILINE)

    m=reg.match(s)
    puts m.to_s
    
    m.to_s
  end
  
  ##
  #财务指标
  def finance_index(stock_code)
    
  end
  
  ##
  #高管信息
  def manager(stock_code)
    
  end
  
  
end



