#
# Base class for all Mongoose database tables in China Stock.
#
class CstockTable < Mongoose::Table
    
  ##
  #如果数据库不存在新建数据库
  def self.ensure( db )
    if !db.table_exists?( table_symbol() )
      db.create_table( table_symbol() ) do |tbl|
        create_table( tbl )
      end
      load_initial_data()
      false
    else
      true
    end
  end
  
  #表类型
  def self.table_symbol()
  end
  
  #建立表
  def self.create_table( tbl )
  end
  
  #初始化,数据
  def self.load_initial_data()
  end
  
end

##
#股票信息
class StockInfo  < CstockTable
  ##
  #股票信息
  def self.table_symbol()
    :stock_info
  end
  #
  def self.create_table( tbl )
    tbl.add_indexed_column( :code, :string ) #股票代码
    tbl.add_column( :name, :string ) #股票名称
    tbl.add_column( :desc, :string) #公司描述
    tbl.add_column( :big_biz, :string) #重大事件
  end
end

#
# 保存历史股票信息，每日
#
class DayList < CstockTable
  
  def self.table_symbol()
    :day_list
  end
  
  def self.create_table( tbl )
    tbl.add_indexed_column( :code, :string )
    tbl.add_column( :open, :float )
    tbl.add_column( :high, :float )
    tbl.add_column( :low, :float )
    tbl.add_column( :close, :float )
    tbl.add_column( :volume, :float )
    tbl.add_column( :adjclose, :float )
    tbl.add_column( :recno, :float )
    tbl.add_column( :date, :integer  )
  end
  
end

#
# 保存股票标准信息，每日
#
class StandList  < CstockTable
 
  def self.table_symbol()
    :stand_list
  end
  
  def self.create_table( tbl )
    tbl.add_indexed_column( :symbol, :string )
    tbl.add_column( :name, :string )
    tbl.add_column( :lastTrade, :string )
    tbl.add_column( :date, :date )
    tbl.add_column( :time, :string )
    tbl.add_column( :change, :float )
    tbl.add_column( :changepoints, :float )
    tbl.add_column( :previousclose, :float )
    tbl.add_column( :open, :float )
    tbl.add_column( :dayhigh, :float )
    tbl.add_column( :daylow, :float )
    tbl.add_column( :volume, :float )
    tbl.add_column( :dayrange, :string)
    tbl.add_column( :lasttradewithtime, :float )
    tbl.add_column( :tickertrend, :string )
    tbl.add_column( :averagedailyvolume, :string )
    tbl.add_column( :bid, :float )
    tbl.add_column( :ask, :float )
  end  
end

##
#扩展信息
class ExtendList < CstockTable
  
  def self.table_symbol()
    :extend_list
  end
  
  def self.create_table( tbl )
    tbl.add_indexed_column( :symbol, :string )
    tbl.add_column( :name, :string )
    tbl.add_column( :weeks52Range, :string )
    tbl.add_column( :weeks52ChangeFromLow, :float )
    tbl.add_column( :weeks52ChangePercentFromLow, :string )
    tbl.add_column( :weeks52ChangeFromHigh, :float )
    tbl.add_column( :weeks52ChangePercentFromHigh, :string )
    tbl.add_column( :peRatio, :float )
    tbl.add_column( :shortRatio, :string )
    tbl.add_column( :dividendPayDate, :string )
    tbl.add_column( :dividendPerShare, :string )
    tbl.add_column( :dividendYield, :string )
    tbl.add_column( :marketCap, :string )
    tbl.add_column( :oneYearTargetPrice, :string )
    tbl.add_column( :epsEstimateCurrentYear, :string )
    tbl.add_column( :epsEstimateNextYear, :string )
    tbl.add_column( :epsEstimateNextQuarter, :string ) 
    tbl.add_column( :pricePerEPSEstimateCurrentYear, :string )
    tbl.add_column( :pricePerEPSEstimateNextYear, :string )
    tbl.add_column( :pegRatio, :float )
    tbl.add_column( :bookValue, :float )
    tbl.add_column( :pricePerBook, :float )
    tbl.add_column( :pricePerSales, :float )
    tbl.add_column( :ebitda, :string )
    tbl.add_column( :movingAve50days, :string )
    tbl.add_column( :movingAve50daysChangeFrom, :string )
    tbl.add_column( :movingAve50daysChangePercentFrom, :string )
    tbl.add_column( :movingAve200days, :string )
    tbl.add_column( :movingAve200daysChangeFrom, :string )
    tbl.add_column( :movingAve200daysChangePercentFrom, :string )
    tbl.add_column( :earningsPerShare, :string )
    tbl.add_column( :pricePaid, :string )
    tbl.add_column( :commission, :string )
    tbl.add_column( :holdingsValue, :string )
    tbl.add_column( :dayValueChange, :string )
    tbl.add_column( :holdingsGainPercent, :string )
    tbl.add_column( :holdingsGain, :string )
    tbl.add_column( :tradeDate, :string )
    tbl.add_column( :annualizedGain, :string )
    tbl.add_column( :highLimit, :string )
    tbl.add_column( :lowLimit, :string )
    tbl.add_column( :notes, :string )
    tbl.add_column( :stockExchange, :string )
  end  
  
end


##
#实时信息
class RealTime < CstockTable
  
  def self.table_symbol()
    :real_time
  end
  
  def self.create_table( tbl )
    tbl.add_indexed_column( :symbol, :string )
    tbl.add_column( :name, :string )
    tbl.add_column( :ask, :float )
    tbl.add_column( :bid, :float )
    tbl.add_column( :change, :string )
    tbl.add_column( :lastTradeWithTime, :string )
    tbl.add_column( :changePoints, :float )
    tbl.add_column( :dayRange, :string )
    tbl.add_column( :marketCap, :string )
  end  
  
end

