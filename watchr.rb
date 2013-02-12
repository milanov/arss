watch(%r{spec/arss/.*?.rb}) do |m|
  system 'cls'

  success = system 'rake unit'

  if success
    system 'color 02'
    puts 'Tests successfully executed :)'
  else
    system 'color 04'
    puts 'Tests failed ;('
  end
end
