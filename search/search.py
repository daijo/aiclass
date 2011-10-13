class TreeNode:

    def __init__(self, name, children, is_goal):
        self.name = name
        self.children = children
        self.is_goal = is_goal

    def display(self):
        print "- Node start -"
        print self.name
        print self.is_goal
        print "- Node end -"

class TreeSearch:

    expanded_nodes = 0

    def __init__(self, start, goRight, depthFirst):
        self.start = start
        self.goRight = goRight
        self.depthFirst = depthFirst

    def display(self):
        print 'TreeSearch: goRight={0} depthFirst={1}'.format(self.goRight, self.depthFirst)

    def print_path(self, path):
        print "* Path start *"
        for s in path:
            s.display()
        print "* Path end *"

    def bylength(self, list1, list2):
        return len(list1) - len(list2)
 
    def remove_choice(self, frontier):
        frontier.sort(cmp=self.bylength)
        if self.depthFirst:
            result = frontier.pop(-1) # return longest path in the frontier
        else:
            result = frontier.pop(0) # return the shortest
        return result

    def search(self):
        frontier = [[start]]
        while True:
            if len(frontier) == 0: 
                return None
            path = self.remove_choice(frontier)
            s = path[-1] # last state in path
            if s.is_goal == True:
                return path
            self.expanded_nodes += 1
            if s.children != None:
                if not self.goRight:
                    for a in s.children:
                        new_path = path + [a]
                        frontier.append(new_path)
                else:
                    for a in reversed(s.children):
                        new_path = path + [a]
                        frontier.append(new_path)

            # raw_input("Press Enter to continue...")

# Homework assignement 'Search Tree'

nodeFive = TreeNode("5", None, False)
goal = TreeNode("Goal", None, True)
nodeSeven = TreeNode("7", None, False)
nodeEight = TreeNode("8", None, False)
nodeNine = TreeNode("9", None, False)
nodeTen = TreeNode("10", None, False)

nodeTwo = TreeNode("2", [nodeFive, goal], False)
nodeThree = TreeNode("3", [nodeSeven, nodeEight], False)
nodeFour = TreeNode("4", [nodeNine, nodeTen], False)

start = TreeNode("start", [nodeTwo, nodeThree, nodeFour], False)

search = TreeSearch(start, True, False)
search.display()
path = search.search()
#print "Path found! ->"
#search.print_path(path)
print "Number of expanded nodes:"
print search.expanded_nodes

search = TreeSearch(start, True, True)
search.display()
path = search.search()
#print "Path found! ->"
#search.print_path(path)
print "Number of expanded nodes:"
print search.expanded_nodes

search = TreeSearch(start, False, False)
search.display()
path = search.search()
#print "Path found! ->"
#search.print_path(path)
print "Number of expanded nodes:"
print search.expanded_nodes

search = TreeSearch(start, False, True)
search.display()
path = search.search()
#print "Path found! ->"
#search.print_path(path)
print "Number of expanded nodes:"
print search.expanded_nodes

# Homework assignement 'Search Tree 2'

