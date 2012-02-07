
module CHRED


  ##
  #先从数据库中找
  #在从接口读入数据
  #保存至数据库
  #返回数据列表
  def CHRED.get_list(symbols,start_date,end_date)
    #从数据库中找
    int_sdate=CHRED.int_from_date(start_date)
    int_edate=CHRED.int_from_date(end_date)
    dat = DayList.find(:order=>-:date){ |d| d.code == symbols and d.date>int_sdate and d.date<int_edate  }
    #puts "data is #{dat.size.to_i} haha"
    #从接口读取
    if dat.size.to_i==0
      #puts "yahoo get"
      dat=CHRED.yahoo_get(symbols,start_date,end_date)
    end
    dat
  end
  
  ##
  #从雅虎获得历史数据
  def CHRED.yahoo_get(symbols,start_date,end_date)
    
    quotes = YahooFinance::get_HistoricalQuotes( symbols ,start_date ,end_date )
      
    db_quote=[]
    for quote in quotes
      pf = DayList.create( :code => symbols,
        :open => quote.open,
        :high => quote.high,
        :low => quote.low,
        :close => quote.close,
        :volume => quote.volume,
        :adjclose => quote.adjClose,
        :recno => quote.recno.to_f,
        :date => CHRED.int_from_date(quote.date))
      db_quote << pf
      #puts "#{pf.code}#{pf.date}"
    end
    db_quote
    # rescue
    #   puts $!
    # end
  end
  
  ##
  #获得 int 值
  def CHRED.int_from_date(date)
    #puts date
    date=Date.parse(date) unless date.is_a?(Date)
    return date.year*10000+date.month*100+date.day
  end
  
end