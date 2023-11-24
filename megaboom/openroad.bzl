load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")

def map(func, iterable):
    result = []
    for item in iterable:
        result.append(func(item))
    return result

def set(iterable):
    result = []
    for item in iterable:
        if item not in result:
            result = result + [item.strip()]
    return result

def filter(iterable, func):
    result = []
    for item in iterable:
        if func(item):
            result = result + [item]
    return result

def build_openroad(
    name,
    verilog_files = [],
    stage_sources = {},
    macros = [],
    io_constraints = "io.tcl",
    stage_args={},
    mock_abstract=False,
    mock_stage=3
):
    all_stages = ([(1, 'synth'), (2, 'floorplan'), (3, 'place'),
    (4, 'cts'), (5, 'route'), (6, 'final'), (7, 'generate_abstract')])

    source_folder_name = name

    output_folder_name = source_folder_name

    all_sources = [
        "orfs",
        "bazel.mk",
        "config.mk"
    ]

    orfs_version = 3

    macro_targets = map(lambda m: ":" + m + "_generate_abstract", macros)

    stage_sources = dict(stage_sources)

    stage_sources['synth'] = stage_sources.get('synth', []) + set(verilog_files)

    stage_args = dict(stage_args)
    ADDITIONAL_LEFS = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/%s.lef' % (m, m), macros))
    ADDITIONAL_LIBS = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/%s.lib' % (m, m), macros))
    ADDITIONAL_GDS_FILES = ' '.join(map(lambda m: '$(RULEDIR)/build/results/asap7/%s/base/6_final.gds' % (m), macros))

    io_constraints_args = ["IO_CONSTRAINTS=" + io_constraints] if io_constraints != None else []

    lefs_args = (["'ADDITIONAL_LEFS=" + ADDITIONAL_LEFS + "'"] if len(macros) > 0 else [])
    libs_args = (["'ADDITIONAL_LIBS=" + ADDITIONAL_LIBS + "'"] if len(macros) > 0 else [])
    gds_args = (["'ADDITIONAL_GDS_FILES=" + ADDITIONAL_GDS_FILES + "'"] if len(macros) > 0 else [])

    stage_args['synth'] = stage_args.get('synth', []) + libs_args + lefs_args + [
        "'VERILOG_FILES=" + ' '.join(set(verilog_files)) + "'",
        "SDC_FILE=" + list(filter(stage_sources.get('synth', []), lambda s: s.endswith(".sdc")))[0]
        ] + io_constraints_args
    stage_args['floorplan'] = stage_args.get('floorplan', []) + lefs_args + libs_args + (
            [] if len(macros) == 0 else [
        '"PDN_TCL=\\$$(PLATFORM_DIR)/openRoad/pdn/BLOCKS_grid_strategy.tcl"']
        )
    stage_args['place'] = stage_args.get('place', []) + libs_args + io_constraints_args

    stage_args['final'] = stage_args.get('final', []) + gds_args + lefs_args + (
        ["GND_NETS_VOLTAGES=\"\"","PWR_NETS_VOLTAGES=\"\""])

    stage_args['route'] = stage_args.get('route', []) + (
        [] if len(macros) == 0 else ['MIN_ROUTING_LAYER=M2',
        'MAX_ROUTING_LAYER=M9'])

    abstract_source = str(mock_stage) + "_" + all_stages[mock_stage - 1][1]
    stage_args['generate_abstract'] = stage_args.get('generate_abstract', []) + gds_args + lefs_args + (
        ['ABSTRACT_SOURCE=' + abstract_source] if mock_abstract else []) + (
            ['GDS_ALLOW_EMPTY="(' + '|'.join(macros) + ')"'] if len(macros) > 0 else [])


    base_args = ["DESIGN_NAME=" + name,
    "DESIGN_CONFIG=config.mk",
    "WORK_HOME=$(RULEDIR)/build",
    "ORFS_VERSION=" + str(orfs_version)]

    reports ={'synth': ['1_1_yosys'],
    'floorplan': ['2_1_floorplan',
        '2_2_floorplan_io',
        '2_3_floorplan_tdms',
        '2_4_floorplan_macro',
        '2_5_floorplan_tapcell',
        '2_6_floorplan_pdn'],
    'place': ['3_1_place_gp_skip_io',
        '3_2_place_iop',
        '3_3_place_gp',
        '3_4_place_resized',
        '3_5_place_dp'],
    'cts': ['4_1_cts'],
    'route': ['5_1_grt',
        '5_2_fillcell',
        '5_3_route'],
    'final': ['6_1_merge',
     '6_report'],
    'generate_abstract': ['generate_abstract']
    }

    outs = {
        'synth':[
            "build/results/asap7/%s/base/1_synth.v" %(output_folder_name),
            "build/results/asap7/%s/base/1_synth.sdc" %(output_folder_name)
        ],
        "generate_abstract": [
            "build/results/asap7/%s/base/%s.lib" %(output_folder_name, name),
            "build/results/asap7/%s/base/%s.lef" %(output_folder_name, name),
        ],
        'final': [
            "build/results/asap7/%s/base/6_final.spef" %(output_folder_name),
            "build/results/asap7/%s/base/6_final.gds" %(output_folder_name)
        ],
        'route': ["build/reports/asap7/%s/base/congestion.rpt" %(output_folder_name),
            "build/reports/asap7/%s/base/5_route_drc.rpt" %(output_folder_name)]
    }

    stages = [stage for stage in all_stages if not mock_abstract or (stage[0] <= mock_stage or stage[0] >= 7)]

    [run_binary(
        name = name + "_" + stage,
        tool = ":orfs",
        srcs = macro_targets + all_sources + ([name + "_" + previous] if i > 1 else [])+
        stage_sources.get(stage, []),
        args = ["make"] +
        base_args +
             ["bazel-" + stage, "elapsed"] +
        stage_args.get(stage, []),
        outs = outs.get(stage, []) + ([
            "build/results/asap7/%s/base/%s.sdc" %(output_folder_name, str(i) + "_" + stage),
            "build/results/asap7/%s/base/%s.odb" %(output_folder_name, str(i) + "_" + stage)
        ] if stage in ["floorplan", "place", "cts", "route", "final"] else []) +
        (["build/results/asap7/%s/base/%s.ok" %(output_folder_name, stage)] if stage in ["place", "route"] else []) +
        list(map(lambda log: "build/logs/asap7/%s/base/%s.log" %(output_folder_name, log), reports[stage]))
    ) for ((j, previous), (i, stage)) in zip([(0, 'n/a')] + stages, stages)]
