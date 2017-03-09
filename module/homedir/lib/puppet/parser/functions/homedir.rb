Puppet::Parser::Functions.newfunction(:homedir,
                                      :type => :rvalue,
                                      :arity => 1,
                                      :doc => 'Returns the conventional Linux home directory of a username.'
                                     ) do |args|
                                       user = args[0]
                                       raise ArgumentError, "Expects a string" unless user.class == String
                                       case user
                                       when 'root'
                                         '/root'
                                       else
                                         "/home/#{user}"
                                       end
                                     end
