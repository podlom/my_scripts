import sys
import random
import os

# Default password length
iPasswdLen = 15


def getRandomArrayValue(a):
    return random.choice(a)


def getRandomChar():
    chars = list(map(chr, range(48, 58))) + list('&*!.,^~#?()[]-_')  # 48-57 are ASCII codes for 0-9
    shuf_chars = ''.join(random.sample(chars, len(chars)))
    return random.choice(shuf_chars)


def getRandomPasswd(passLen):
    wordsList = os.path.join(os.path.dirname(__file__), 'linux.words.txt')
    try:
        with open(wordsList, 'r') as f:
            aW1 = f.readlines()
    except IOError:
        return 'Error opening words list file!'

    if aW1:
        passw = ''
        while len(passw) < passLen:
            r1 = getRandomArrayValue(aW1).strip()
            passw += r1[0].upper() + r1[1:]
            if len(passw) > passLen:
                passw = passw[:passLen]

        for _ in range(3):  # Add random char 3 times for password hardening
            random_pos = random.randint(1, passLen - 1)
            passw = passw[:random_pos] + getRandomChar() + passw[random_pos:]

        return passw
    return 'Error generating random password!'


if __name__ == '__main__':
    if len(sys.argv) > 1:
        iUserPasswdLen = int(sys.argv[1])
        if iUserPasswdLen > 0:
            print(f"Random password ({iUserPasswdLen}) is: {getRandomPasswd(iUserPasswdLen)}")
            sys.exit()
    print(f"Random password ({iPasswdLen}) is: {getRandomPasswd(iPasswdLen)}")
