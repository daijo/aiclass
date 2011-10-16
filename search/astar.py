class Map:

    def __init__(self, width, height):
        self.nodeMap = [None] * width
        i = 0
        while i < len(self.nodeMap):
            self.nodeMap[i] = [None] * height
            i = i + 1
        self.width = len(self.nodeMap)
        self.height = len(self.nodeMap[0])

    def getNode(self, x, y):
        return self.nodeMap[x][y]      

    def setNode(self, x, y, node):
        self.nodeMap[x][y] = node
        node.setCoordinate(x, y, self)

class MapNode:

    def __init__(self, name, cost): # todo: query cost when needed
        self.name = name
        self.cost = cost

    def setCoordinate(self, x, y, nodeMap):
        self.x = x
        self.y = y
        self.nodeMap = nodeMap

    def display(self):
        print "- Node start -"
        print self.name
        print "- Node end -"

    #def distance_between(self, node1, node2):
     #   return abs(node1.x - node2.x) + abs(node1.y - node2.y) # Manhattan distance

    def get_neighbours(self):
        result = []
        if self.x > 0 and self.nodeMap.getNode(self.x - 1, self.y) != None:
            result.append(self.nodeMap.getNode(self.x - 1, self.y))
        if self.x < self.nodeMap.width - 1 and self.nodeMap.getNode(self.x + 1, self.y) != None:
            result.append(self.nodeMap.getNode(self.x + 1, self.y))
        if self.y > 0 and self.nodeMap.getNode(self.x, self.y - 1) != None:
            result.append(self.nodeMap.getNode(self.x, self.y - 1))
        if self.y < self.nodeMap.height - 1 and self.nodeMap.getNode(self.x, self.y + 1) != None:
            result.append(self.nodeMap.getNode(self.x, self.y + 1))

        return result
        
class AStarSearch:

    def __init__(self, nodeMap):
        self.nodeMap = nodeMap

    def print_path(self, path):
        print "* Path start *"
        for s in path:
            s.display()
        print "* Path end *"

    def by_known_cost(self, list1, list2):
        return list1[-1].cost - list2[-1].cost 
 
    def remove_choice(self, frontier):
        frontier.sort(cmp=self.by_known_cost)
        return frontier.pop(0) # return the lowest ranked

    def is_in_frontier(self, frontier, node_to_test):
        for path in frontier:
            for node in path:
                if node == node_to_test:
                    return True
        return False

    def search(self, start, goal): 
        frontier = [[start]]
        explored = []
        while True:
            if len(frontier) == 0: 
                return None
            path = self.remove_choice(frontier)
            s = path[-1] # last state in path
            s.display()
            explored.append(s)
            if s == goal:
                return path
            neighbours = s.get_neighbours()
            if neighbours != None:
                for a in neighbours:
                    new_path = path + [a]
                    if not a in explored and not self.is_in_frontier(frontier, a):
                       frontier.append(new_path)

            raw_input("Press Enter to continue...")


# Homework assignement 'A* Search'

print "A* Star"

myMap = Map(6, 4)

start = MapNode("a1", 0 + 4)
myMap.setNode(0, 0, start)
myMap.setNode(1, 0, MapNode("a2", 1 + 4)) 
myMap.setNode(2, 0, MapNode("a3", 2 + 4)) 
myMap.setNode(3, 0, MapNode("a4", 3 + 3)) 
myMap.setNode(4, 0, MapNode("a5", 4 + 2))
myMap.setNode(5, 0, MapNode("a6", 5 + 1))
myMap.setNode(0, 1, MapNode("b1", 1 + 3))
myMap.setNode(1, 1, MapNode("b2", 2 + 3)) 
myMap.setNode(2, 1, MapNode("b3", 3 + 3)) 
myMap.setNode(3, 1, MapNode("b4", 4 + 3)) 
myMap.setNode(4, 1, MapNode("b5", 5 + 2))
myMap.setNode(5, 1, MapNode("b6", 6 + 1))
myMap.setNode(0, 2, MapNode("c1", 2 + 2))
myMap.setNode(1, 2, MapNode("c2", 3 + 2)) 
myMap.setNode(2, 2, MapNode("c3", 4 + 2)) 
myMap.setNode(3, 2, MapNode("c4", 5 + 2)) 
myMap.setNode(4, 2, MapNode("c5", 6 + 2))
myMap.setNode(5, 2, MapNode("c6", 7 + 1))
myMap.setNode(0, 3, MapNode("d1", 3 + 1))
myMap.setNode(1, 3, MapNode("d2", 4 + 1)) 
myMap.setNode(2, 3, MapNode("d3", 5 + 1)) 
myMap.setNode(3, 3, MapNode("d4", 6 + 1)) 
myMap.setNode(4, 3, MapNode("d5", 7 + 1))
goal = MapNode("d6", 8 + 0)
myMap.setNode(5, 3, goal) 

search = AStarSearch(myMap)
path = search.search(start, goal)
search.print_path(path)
