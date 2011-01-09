#Reverse Polish Notation calculator

A simple implementation of a RPN (also known as _postfix_ notation) calculator.

In a nutshell, this notation consists of operands followed by their operators.
As opposed to express an operation like this...

    (3 + 4) * 7 - 1

...in reverse Polish notation it would look like this:

    7 3 4 + * 1 -

It basically works like a stack in which you push operands until you find an
operator; given an arity _n_, you evaluate this operator with _n_ numbers from
the stack, and substitute them for their result. Check out the [Wikipedia
article](http://en.wikipedia.org/wiki/Reverse_Polish_notation) to learn more about this notation.

##Install

    gem install rpn

##Usage

Just require it in your Gemfile:

    gem 'rpn'

Note: If you are not using Bundler, you should `require 'rpn'` manually.

Now you have to initialize a calculator. You can provide a custom _n_ arity 
(the number of operands that will get evaluated by each operator). Default
arity is 2. You can also provide the delimiter the parser will use (will be ' '
by default).

    my_rpn = RPN::Calculator.new # => will use the defaults
    my_rpn.solve "7 3 4 + * 1 -"
    # => 48

For now, it supports the following operators:

    + - * / ^

##Contribute!

* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so I don't break it in a future
  version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Josep M. Bach. See LICENSE for details.
