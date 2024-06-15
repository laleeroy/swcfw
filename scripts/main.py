import json

import bootloaders
import cfws
import firmwares
import hekate
import payloads
import hekate_ipl


if __name__ == '__main__':

    json_file = "updates.json"
    try:
        with open(json_file, "r") as old_file:
            out = json.load(old_file)
    except (FileNotFoundError, json.decoder.JSONDecodeError):
        out = {}

    modules = [
        cfws.Cfws(),
        firmwares.Firmwares()
    ]
    for module in modules:
        if module.out == {}:
            print(f"Module {module.__module__} returned an empty dict.")
            continue
        out[module.__module__] = module.out

    with open(json_file, 'w') as out_file:
        json.dump(out, out_file, indent=4)
