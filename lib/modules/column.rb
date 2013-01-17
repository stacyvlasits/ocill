class Column
  attr_accessor :drill

  def initialize(drill = '')
    @drill = drill
  end

  def header_row
    drill.header_row
  end

  def row

  end
end
