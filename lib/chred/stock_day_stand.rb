
module CHRED


  ##
  #先从数据库中找
  #在从接口读入数据
  #保存至数据库
  #返回数据列表
  def CHRED.get_stand(symbols)
    #从数据库中找
    #puts "yahoo get stand #{symbols}"
    standard_hash=YahooFinance::get_standard_quotes( symbols )
    s=standard_hash["#{symbols.upcase}"]
    s
    #standard=StandList.create(s)
    #standard
  end
  
  ##
  #从雅虎获得历史数据
  #  def CHRED.yahoo_get(symbols,start_date,end_date)
  #    
  #    quotes = YahooFinance::get_HistoricalQuotes( symbols ,start_date ,end_date )
  #      
  #    db_quote=[]
  #    for quote in quotes
  #      pf = DayList.create( :code => symbols,
  #        :open => quote.open,
  #        :high => quote.high,
  #        :low => quote.low,
  #        :close => quote.close,
  #        :volume => quote.volume,
  #        :adjclose => quote.adjClose,
  #        :recno => quote.recno.to_f,
  #        :date => CHRED.int_from_date(quote.date))
  #      db_quote << pf
  #      puts "#{pf.code}#{pf.date}"
  #    end
  #    db_quote
  #    # rescue
  #    #   puts $!
  #    # end
  #  end
  #  
end