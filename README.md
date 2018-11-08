# compsci682_final_project

## Setup
```
git clone https://github.com/ycyen/compsci682_final_project.git
cd compsci682_final_project
chmod +x setup_gcloud_u16.04.sh
./setup_gcloud_u16.04.sh
```

## Usage
```
python dqn.py train
python dqn.py keeptrain
python dqn.py test
```

## Tmux - mini tutorial
##### create a tmux window
```
tmux
```
#### detach from a tmux window (window still running in the background)
```
ctrl + B
d
```
#### check current windows running in the background
```
tmux ls
```
#### return to a window
```
tmux a
```
