from enum import Enum

class Side(Enum):
    LEFT = 1
    RIGHT = 2


class Intersection:
    def __init__(self, side, segments):
        self.side = side
        self.segments = segments


def f(intersection):

    l = intersection.segments[0]
    m = intersection.segments[1]
    r = intersection.segments[2]

    # Base case
    if len(intersection.segments) == 3:
        if intersection.side == Side.LEFT:
            return min(l, m + r)
        elif intersection.side == Side.RIGHT:
            return min(r, m + l)

    further_segments = intersection.segments[3:]

    next_intersection_on_left = Intersection(side = Side.LEFT, segments = further_segments)
    next_intersection_on_right = Intersection(side = Side.RIGHT, segments = further_segments)

    if intersection.side == Side.LEFT:

        best_path_going_left = l + f(next_intersection_on_left)
        best_path_going_right = m + r + f(next_intersection_on_right)

        return min(best_path_going_left, best_path_going_right)

    elif intersection.side == Side.RIGHT:

        best_path_going_left = m + l + f(next_intersection_on_left)
        best_path_going_right = r + f(next_intersection_on_right)

        return min(best_path_going_left, best_path_going_right)
    

intersection_A = Intersection(side = Side.LEFT, segments = [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8])

least_time_needed = f(intersection_A)

print(least_time_needed)

