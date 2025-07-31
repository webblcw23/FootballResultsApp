import json

to_do_list = []

def save_tasks():
    with open("Python/tasks.json", "w") as file:
        json.dump(to_do_list, file)
    print("Tasks saved to file.")

def load_tasks():
    global to_do_list
    try:
        with open("tasks.json", "r") as file:
            to_do_list = json.load(file)
        print("Tasks loaded from file.")
    except FileNotFoundError:
        print("No saved tasks found.")

def add_task(task):
    to_do_list.append({"task": task, "completed": False})
    print(f"'{task}' has been added to your to-do list.")

def view_tasks():
    if not to_do_list:
        print("Your to-do list is empty!")
    else:
        print("Here are your tasks:")
        for i, task in enumerate(to_do_list, 1):
            status = "✔️" if task["completed"] else "❌"
            print(f"{i}. {task['task']} [{status}]")

def mark_completed(task_number):
    if 0 < task_number <= len(to_do_list):
        to_do_list[task_number - 1]["completed"] = True
        print(f"Task {task_number} marked as complete!")
    else:
        print("Invalid task number.")

# Example usage
load_tasks()
add_task("Learn Python")
add_task("Workout")
mark_completed(2)
view_tasks()
save_tasks()
