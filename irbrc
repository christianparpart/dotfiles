require 'rubygems'

begin
	require 'wirble'
	Wirble::History::DEFAULTS[:history_uniq] = 'reverse'

	colors = Wirble::Colorize.colors.merge({
		:symbol => :cyan,
		:symbol_prefix => :blue,
		:class => :dark_gray,
		:comma => :gray,
	})
	Wirble::Colorize.colors = colors
	Wirble.init
	Wirble.colorize
#rescue LoadError => e
end
