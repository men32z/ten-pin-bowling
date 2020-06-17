class Validate
  def initialize(item, validation)
    # available methods
    @a_m = %w[min max number]
    @current_item = item
    @validations = format(validation)
    @current_validation = 0
  end

  def valid?
    result = true
    @validations.each do |v|
      @current_validation = v[1] if v[1]
      result &&= send(v[0]) if v[0] && Validate.private_method_defined?(v[0]) && @a_m.include?(v[0])
    end
    result
  end

  private

  def max
    number && @current_item <= @current_validation.to_f
  end

  def min
    number && @current_item >= @current_validation.to_f
  end

  def number
    @current_item.is_a? Numeric
  end

  def format(validation)
    validation.split('|').map { |e| e.split(':') }
  end
end
