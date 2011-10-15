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

    def __init__(self, start, goLeftToRight, depthFirst):
        self.start = start
        self.goLeftToRight = goLeftToRight
        self.depthFirst = depthFirst

    def display(self):
        print 'TreeSearch: goLeftToRight={0} depthFirst={1}'.format(self.goLeftToRight, self.depthFirst)

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

    def is_in_frontier(self, frontier, node_to_test):
        for path in frontier:
            for node in path:
                if node == node_to_test:
                    return True
        return False

    def search(self): # todo: add explored set
        frontier = [[start]]
        explored = []
        while True:
            if len(frontier) == 0: 
                return None
            path = self.remove_choice(frontier)
            s = path[-1] # last state in path
            self.expanded_nodes += 1
            s.display()
            explored.append(s)
            if s.is_goal == True:
                return path
            if s.children != None:
                if not self.goLeftToRight:
                    for a in s.children:
                        new_path = path + [a]
                        if not a in explored and not self.is_in_frontier(frontier, a):
                            frontier.append(new_path)
                else:
                    for a in reversed(s.children):
                        new_path = path + [a]
                        if not a in explored and not self.is_in_frontier(frontier, a):
                            frontier.append(new_path)

            raw_input("Press Enter to continue...")


# Homework assignement 'Search Network'

print "Homework Search Network"

nodeSixteen = TreeNode("16", None, False)

nodeFourteen = TreeNode("14", [nodeSixteen], False)
nodeFifthteen = TreeNode("15", [nodeSixteen], False)

nodeEleven = TreeNode("11", [nodeFourteen], False)
nodeTwelve = TreeNode("12", [nodeFourteen, nodeFifthteen], False)
nodeThirteen = TreeNode("13", [nodeFifthteen], False)

nodeSeven = TreeNode("7", [nodeEleven], False)
nodeEight = TreeNode("8", [nodeEleven, nodeTwelve], False)
nodeNine = TreeNode("9", [nodeTwelve, nodeThirteen], False)
goal = TreeNode("Goal", [nodeThirteen], True)

nodeFour = TreeNode("4", [nodeSeven, nodeEight], False)
nodeFive = TreeNode("5", [nodeEight, nodeNine], False)
nodeSix = TreeNode("6", [nodeNine, goal], False)

nodeTwo = TreeNode("2", [nodeFour, nodeFive], False)
nodeThree = TreeNode("3", [nodeFive, nodeSix], False)

start = TreeNode("start", [nodeTwo, nodeThree], False)

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


