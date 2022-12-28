

class SQLDataBuilder:
    def __init__(self, preview: str, standard: str,
                 full: str, minium: str, extend: str):
        self.minium = minium
        self.preview = preview
        self.standard = standard
        self.full = full
        self.extend = extend
