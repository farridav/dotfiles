import re

import sublime
import sublime_plugin


class CopyPythonPathCommand(sublime_plugin.TextCommand):

    def get_regions(self, selector):
        return [
            (self.view.rowcol(r.begin())[0], self.view.substr(r))
            for r in self.view.find_by_selector(selector)]

    def get_lines(self):
        return [self.view.rowcol(r.begin())[0] for r in self.view.sel()]

    def filter_selected_regions(self, regions, lines):
        rr = regions[:]
        rr.reverse()
        filtered = []
        r_end = None
        for r in rr:
            for l in lines:
                if l >= r[0] and (r_end is None or l <= r_end):
                    filtered.append(r)
                    break
            r_end = r[0] - 1
        filtered.reverse()
        return filtered

    def fixup_function_names(self, regions):
        retval = []
        for r in regions:
            m = re.match(r'^\s+def\s+([a-zA-Z0-9_]+)\(', r[1])
            if m:
                r = (r[0], m.groups()[0])
            if r[1].startswith('test_'):
                retval.append(r)
        return retval

    def merge_class_fn_regions(self, cls_regions, fn_regions):
        rr = cls_regions[:]
        rr.reverse()
        merged = []
        r_end = None
        used_fn = []
        for r in rr:
            used_cls = False
            for f in fn_regions:
                if (
                    f[0] > r[0] and
                    (r_end is None or f[0] <= r_end) and not
                    f[0] in used_fn
                ):
                    merged.append('%s.%s' % (r[1], f[1]))
                    used_fn.append(f[0])
                    used_cls = True
            r_end = r[0] - 1
            if not used_cls:
                merged.append(r[1])
        return merged

    def run(self, edit):
        if 'Python' not in self.view.settings().get('syntax'):
            return

        lines = self.get_lines()

        cls_regions = self.filter_selected_regions(
            self.get_regions('entity.name.type.class'), lines)

        fn_regions = self.filter_selected_regions(
            self.get_regions('meta.function'), lines)
        fn_regions = self.fixup_function_names(fn_regions)

        regions = self.merge_class_fn_regions(cls_regions, fn_regions)

        sublime.set_clipboard(regions[0])
        sublime.status_message("Copied {} to clipboard.".format(regions[0]))

    def test_thing(self):
        pass
