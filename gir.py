#!/usr/bin/python
import random
import sys
import textwrap
import subprocess
import os

def chunks(l, n):
    """ Yield successive n-sized chunks from l.
    """
    for i in xrange(0, len(l), n):
        yield l[i:i+n]

random.seed()

quotes_t = \
"""
Tell me a story about giant pigs!

Zim: Gir! Come to the observatory!
Gir: Yeees?
Zim: What have you done to the telescope?
Gir: Nothin'...
Zim: You haven't touched it? Something is broken and it's not your fault?
Gir: I know, I'm scared too!

Zim: I am the only one who can decode the files!
Dib: And I am the one with the files to be decoded!
Gir: AND I'M... AAAH-ahah... I dunno.

I love this show!

I'm gonna sing the Doom Song now.
Doom doom doom doom doomy doomy doom doomy doom doom doom doom doom doom doom...

Zim: What are you watching?
Gir: Angry monkey.
Zim: That horrible monkey!
Gir: Mmhmm.

Awww... I wanted to explode.

Somebody needs a hug!

CHICKEN! I'm gonna eat you!

I'm gonna roll around on the floor for a while. KAY?

Aww, but I wanna watch the Scary Monkey Show!

Hi floor! Make me a sandwich!
"""

quotes_l = quotes_t.split('\n\n')
gir_image = """
                                         __
                                  __.--:'  `._
                            _.--`'       .    `.
                        _.-'               .    `.
                      .'                     .    \--```-.
                    .'            _,-'``-..    .   \      `.
               ----|            ,'         `.   .   \     . |
              /_.--|           :             ;   .   \      |
                   |           |      .      |    :   \     '
                   |           |             :     _   ;  .'
           __.--:==|_           .           /     "'   :-'
      _.--' _.-'     `-._        `.       .'_.-------./
     |   ._'             `.    .-''-,...-'        :  /
     | .'                  '._     / | \         _..'
     |'                       `. '''`--'     _..'
                                \          .'
                                /       .-'        .
                               /    ,_ , \'--.__  / \   ___
                          __  /    ,/ \ = \_.---`'--,\.'  .`.
                           `"/    _(   \-"'           `-.    \\
                             \    \ '`-,\ _....         _>----._
                              )+.`'\    .'     `-.    .'     .-.`.
                             / /    `  .'   .    `. ./   __  \  \ \\
                            _""        |          | ;   /  \  `._)|
                           .'           \        /  `   \   )     |
                          .'             `-.---.'    `   `-'     .'
                          |                           `        .'
                          |                             `__.-' ;
                          |                             _.-    /
                          \                                  .'
                           \                              _,'\\
                            \                           ,'   /
                             `,                  \     .`___'
                            _,_),_              .-`._,'
                           (__.-' `-.,,    .--'|
                          (_.'   dew   `._,'--'
                        -='
"""

border = '  ############################################################################  '

quote = quotes_l[random.randint(0, len(quotes_l) - 1)]

lines = [textwrap.wrap(line, 72, subsequent_indent='  ') for line in quote.splitlines()]
lines_t = []
for line_l in lines:
    lines_t = lines_t + line_l

print gir_image
print border
for line in lines_t:
    pad_length = (72 - len(line))
    pad_string = ' '*pad_length
    print '  # ' + line + pad_string + ' #'
print border
print

args = ["git"] + sys.argv[1:]
subprocess.call(args)                          
