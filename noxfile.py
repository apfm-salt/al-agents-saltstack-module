import os
import sys
import nox

if __name__ == "__main__":
    sys.stderr.write(
        "Do not execute this file directly. Use nox instead, it will know how to handle this file\n"
    )
    sys.stderr.flush()
    exit(1)

# Yay Globals!
REPO_ROOT = os.path.abspath(os.path.dirname(__file__))
SITECUSTOMIZE_DIR = os.path.join(REPO_ROOT, "tests", "support", "coverage")
IS_DARWIN = sys.platform.lower().startswith("darwin")
IS_WINDOWS = sys.platform.lower().startswith("win")
IS_FREEBSD = sys.platform.lower().startswith("freebsd")

_SALT_VERSIONS = (None, "3001.7", "3002.6", "3003", "latest")


@nox.session
@nox.parametrize("salt", _SALT_VERSIONS)
def pull_request(session, salt):
    """
    Run pull_request tests
    """
    session.install("pyyaml")
    if salt:
        if salt == "latest":
            session.install("salt")
        else:
            session.install("salt=={}".format(salt))
    if session.posargs:
        target_states = session.posargs
    else:
        target_states = ["alertlogic.user", "alertlogic.agent"]

    root_dir = os.path.join(os.getcwd(), session.create_tmp())
    session.run_always("python", "scripts/gen-minion-config", root_dir)
    salt_call = ["salt-call", "-l", "debug", "--local", "-c", ".salttest"]
    session.run(*salt_call, "state.show_sls", *target_states)


@nox.session
def lint(session):
    """
    Run lint tests
    """
    session.install("pre-commit")
    session.run("pre-commit", "run", "--all")
