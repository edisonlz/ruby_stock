
$LOAD_PATH << File.expand_path( File.dirname( __FILE__  ) + '/extern' )
$LOAD_PATH << File.expand_path( File.dirname( __FILE__  ) + '/chart' )

#puts $LOAD_PATH

# Require the external projects bundled with Grism.
require 'yahoofinance'
require 'kirbybase'
require 'mongoose'

# Require other dependent projects not bundled with Grism.
require 'thread'
require 'date'
require 'base64'

# Require Chred files.n'

require 'chred/chred_constants'
require 'chred/mongoose_db'
require 'chred/chred_ui_helpers'
require 'chred/day_list'
require 'chred/stock_real_time'
require 'chred/stock_day_stand'
require 'chred/stock_day_extend'
require 'chred/parse_stock'

