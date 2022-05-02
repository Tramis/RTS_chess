
extends Node

# use Array as Set
# assume there is no repeat inside

static func union(a, b):
    var tmp = []
    for x in a:
        tmp.push_back(a)
    for x in b:
        if ! x in tmp:
            tmp.push_back(x)
    return tmp

static func intersect(a, b):
    var tmp = []
    for x in a:
        if x in b:
            tmp.push_back(x)
    return tmp

static func minus(a, b):
    var tmp = []
    for x in a:
        if !x in b:
            tmp.push_back(x)
    return tmp
