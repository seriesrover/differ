module Retry

  def with_retry(count, options={})
    begin
      count -= 1
      yield
    rescue
      raise if count < 0
      
      if options[:user_continue]
        puts "Retries left: #{count}.  Press <Enter> to continue."
        gets.chomp
      end

      retry
    end
  end

end
