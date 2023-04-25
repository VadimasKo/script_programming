import os
import datetime

def get_file_info(file_path):
  file_name = os.path.basename(file_path)
  file_dir = os.path.dirname(file_path)
  file_stats = os.stat(file_path)
  create_time = datetime.datetime.fromtimestamp(file_stats.st_ctime).strftime('%Y-%m-%d %H:%M:%S')
  access_time = datetime.datetime.fromtimestamp(file_stats.st_atime).strftime('%Y-%m-%d %H:%M:%S')
  result = f"\nFile Name: {file_name} \nFile Path: {file_dir}\nCreate Time: {create_time}\nAccess Time: {access_time}"
  return result

def get_directory_info(dir_path):
  dir_name = os.path.basename(dir_path)
  dir_content = os.listdir(dir_path)
  dir_stats = os.stat(dir_path)
  create_time = datetime.datetime.fromtimestamp(dir_stats.st_ctime).strftime('%Y-%m-%d %H:%M:%S')
  access_time = datetime.datetime.fromtimestamp(dir_stats.st_atime).strftime('%Y-%m-%d %H:%M:%S')
  content_result = ""
  for item in dir_content:
      content_result += f"{item}\n"
  result = f"Directory Name: {dir_name}\nDirectory Path: {dir_path}\nCreate Time: {create_time}\nAccess Time: {access_time}\n\nContents:\n{content_result}" 
  return result

def search_file_or_directory(path):
  if os.path.isfile(path):
    return get_file_info(path)
  elif os.path.isdir(path):
    return get_directory_info(path)
  else:
    return f"{path} is not a valid file or directory."

def write_to_log_file(date, parameter, result):
  delimiter = "####"
  with open("log.txt", "a") as log_file:
    log_file.write(f"{date}{delimiter}{parameter}{delimiter}{result}\n")

if __name__ == "__main__":
  path = input("Please enter a file or directory path: ")
  result = search_file_or_directory(path)
  print(result)
  date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
  write_to_log_file(date, path, result)
