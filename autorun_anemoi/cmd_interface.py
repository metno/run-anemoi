import argparse

from autorun_anemoi import AutoRunAnemoi
from autorun_anemoi.utils import merge, string_to_nested_dict


def get_parser():
    parser = argparse.ArgumentParser(description="Automatized execution of AnemoI runs")
    parser.add_argument('config', type=str, help='Path to main config')
    parser.add_argument('job_yaml', type=str, help='Path to yaml file containing sbatch commands')
    parser.add_argument('-t', '--total_time', type=str, default=None, help='Expected total execution time, splitted across several jobs if needed. Format: D-HH-MM-SS or HH-MM-SS')
    parser.add_argument('-m', '--max_time_per_job', type=str, default=None, help='Maximum execution time per job. Format: D-HH-MM-SS or HH-MM-SS')
    parser.add_argument('-i', '--inference_config', type=str, default=None, help='Inference config file. Will start inference dependency job if given')
    parser.add_argument('--tmp_dir', type=str, default='tmp_dir', help='Path to temporary dir containing modified config, jobscripts etc..')
    parser.add_argument('--python_script', type=str, default='train.py', help='Python script to be executed')
    parser.add_argument('--inference_python_script', type=str, default='inference.py', help='Inference Python script to be executed')
    parser.add_argument('-j', '--inference_job_yaml', type=str, default=None, help='Path to inference yaml file containing sbatch commands')
    parser.add_argument('--system', type=str, default='lumi', help='Where to run anemoi training')
    return parser


def run():
    args, unknown = get_parser().parse_known_args()

    unknown_dct = {}
    for element in unknown:
        dct = string_to_nested_dict(element)
        unknown_dct = merge(unknown_dct, dct)

    obj = AutoRunAnemoi(args.config,
                        args.job_yaml,
                        total_time=args.total_time,
                        max_time_per_job=args.max_time_per_job,
                        inference_config=args.inference_config,
                        system=args.system,
    )

    obj.modify_config(**unknown_dct)
    obj.run(tmp_dir=args.tmp_dir,
            python_script=args.python_script,
            inference_python_script=args.inference_python_script,
            inference_job_yaml=args.inference_job_yaml,
    )
