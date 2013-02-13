watch(%r{spec/arss/.*?.rb}) do |m|
  system 'cls'

  tests_success = system 'rake unit'

  if tests_success
    system 'color 02'
    puts 'Tests successfully executed :)'
    system 'rake style'
  else
    system 'color 04'
    puts 'Tests failed ;('
  end
end
