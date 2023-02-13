class ApplicationController < ActionController::Base
  def blank_square_form
    render({:template => "calculation_templates/square_form.html.erb" })
  end

  def calculate_square
    # params = {"number"=> "42"}
    @num = params.fetch("calculate_square").to_f
    # @square_of_num = @num * @num
    @square_of_num = @num ** 2
    render({:template => "calculation_templates/square_results.html.erb"})
  end

  def blank_random_form
    render({:template => "calculation_templates/random_form.html.erb" })
  end

  def calculate_random
    @lower = params.fetch("user_min").to_f
    @upper = params.fetch("user_max").to_f
    @result = rand(@lower..@upper)
    render({:template => "calculation_templates/random_results.html.erb"})
  end  

  def blank_root_form
    render({:template => "calculation_templates/root_form.html.erb" })
  end

  def calculate_root
    @num = params.fetch("calculate_root").to_f
    @root_of_num = Math.sqrt(@num)
    render({:template => "calculation_templates/root_results.html.erb"})
  end

  def blank_payment_form
    render({:template => "calculation_templates/payment_form.html.erb"})
  end 

  def calculate_payment
    @apr = params.fetch("apr").to_f
    @num_of_years = params.fetch("num_years")
    @principal = params.fetch("principal").to_f

    num_of_months = @num_of_years.to_f * 12
    # @apr = @apr.to_s(:percentage) / 100
    # @apr = @apr.to_i / 100
    a = @apr.to_f / 100
    rate_per_period = a / 12
    @apr = @apr.to_s(:percentage,{:precision =>4})



    numerator = rate_per_period * @principal
    denominator = 1 - (1 + rate_per_period)**(- num_of_months)
    @principal = @principal.to_s(:currency, {:precision =>2})

    # @payment = numerator / denominator.to_s(:currency)
    @payment = (numerator / denominator).round(2).to_s(:currency)

    render({:template => "calculation_templates/payment_results.html.erb"})
  end

end
