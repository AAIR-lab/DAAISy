#!/usr/local/bin/python3
# encoding: utf-8

class PATuple:
    def __init__(self, predicate=None, action=None):
        self.predicate = predicate
        self.action = action

    def __str__(self):
        return f"PATuple(predicate={self.predicate.__str__()}, action={str(self.action)})"

    def __hash__(self):
        return hash(str(self))

    def __eq__(self, other):
        return (hash(str(self)) == hash(str(other)))

    def __repr__(self):
        return str(self)
