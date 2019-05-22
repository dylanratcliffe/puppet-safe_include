Puppet::Functions.create_function(:safe_include) do
  dispatch :single do
    param 'Optional[String]', :class_name
  end

  dispatch :array do
    param 'Array[Variant[String, Undef]]', :class_list
  end

  def single(class_name)
    return nil if class_name.nil?
    call_function('include', class_name) if call_function('safe_include::class_exists', class_name)
  end

  def array(class_list)
    class_list.flatten.each do |cls|
      single(cls)
    end
  end
end
