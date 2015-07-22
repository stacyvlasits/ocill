class Responses < Array
  def initialize(*args)
    if args[0].kind_of?(Integer)
      super(args[0], Response.new)
    elsif args[0].kind_of?(Array)
      args[0] = args[0].map{|el| Response.new(el)}
      super
    elsif args[0].kind_of?(Hash)
      args[0] = [Response.new(args[0])]
      super
    else
      super
    end
  end
end
