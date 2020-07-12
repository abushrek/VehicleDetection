#!/bin/bash
python export_tflite_ssd_graph.py --pipeline_config_path=ssd_inception_v2/training/ssd_inception_v2.config --trained_checkpoint_prefix=ssd_inception_v2/training/model.ckpt-40000 --output_directory=tflite --add_postprocessing_op=true
python tflite_convert.py --graph_def_file=tflite/tflite_graph.pb --output_file=tflite/detect.tflite --output_format=TFLITE --input_shapes=1,300,300,3 --allow_custom_ops --input_arrays=normalized_input_image_tensor --output_arrays='TFLite_Detection_PostProcess','TFLite_Detection_PostProcess:1','TFLite_Detection_PostProcess:2','TFLite_Detection_PostProcess:3' --post_training_quantize --quantize_to_float16 --mean_values=128 --std_dev_values=128 --default_ranges_min=0 --default_ranges_max=6
