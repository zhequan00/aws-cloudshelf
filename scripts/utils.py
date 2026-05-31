# utils.py
RED    = "\033[91m"
GREEN  = "\033[92m"
YELLOW = "\033[93m"
BOLD   = "\033[1m"
RESET  = "\033[0m"

REGION = "ap-southeast-1"

def ok(msg):     print(f"  {GREEN}✓{RESET} {msg}")
def warn(msg):   print(f"  {YELLOW}⚠{RESET}  {msg}")
def risk(msg):   print(f"  {RED}✗{RESET} {msg}")
def header(msg): print(f"\n{BOLD}{'─'*50}\n  {msg}\n{'─'*50}{RESET}")
