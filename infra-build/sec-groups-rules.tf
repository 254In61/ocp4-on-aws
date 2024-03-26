// 1. MASTER SEC GROUP RULE 

// 1.1 etcd packets

resource "aws_security_group_rule" "etcd-m-2-m" {
  description              = "master to master etcd traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
}

// 1.2 vxlan packets

resource "aws_security_group_rule" "vxlan-m-2-m" {
  description              = "master to master vxlan traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}

resource "aws_security_group_rule" "vxlan-w-2-m" {
  description              = "worker to master vxlan traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}

resource "aws_security_group_rule" "vxlan-w-2-w" {
  description              = "worker to worker vxlan traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}

resource "aws_security_group_rule" "vxlan-m-2-w" {
  description              = "master to worker vxlan traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
}


// 1.3 Geneve packets

resource "aws_security_group_rule" "geneve-m-2-m" {
  description              = "master to master geneve traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

resource "aws_security_group_rule" "geneve-w-2-m" {
  description              = "worker to master geneve traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

resource "aws_security_group_rule" "geneve-w-2-w" {
  description              = "worker to worker  geneve traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

resource "aws_security_group_rule" "geneve-m-2-w" {
  description              = "master to worker geneve traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 6081
  to_port                  = 6081
  protocol                 = "udp"
}

// 1.4 : IpSec IKE packets

resource "aws_security_group_rule" "IpsecIke-m-2-m" {
  description              = "master to master IpsecIke traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ipsecike-w-2-m" {
  description              = "worker to master IpsecIke traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecIke-w-2-w" {
  description              = "worker to worker IpsecIke traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecIke-m-2-w" {
  description              = "master to worker IpsecIke traffic"
  security_group_id        = aws_security_group.worker-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 500
  to_port                  = 500
  protocol                 = "udp"
}


// 1.5 IpSec NAT packets *** NEXT

resource "aws_security_group_rule" "IpsecNat-m-2-m" {
  description              = "master to master IpsecNat traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 4500
  to_port                  = 4500
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IpsecNat-w-2-m" {
  description              = "worker to master IpsecNat traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 4500
  to_port                  = 4500
  protocol                 = "udp"
}

/*
!!! Needs from_port and to_port!

resource "aws_security_group_rule" "IpsecEsp-m-2-m" {
  description              = "master to master IpsecEsp traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  protocol                 = 50
}

resource "aws_security_group_rule" "IpsecEsp-w-2-m" {
  description              = "worker to master IpsecEsp traffic"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  protocol                 = 50
}

*/


resource "aws_security_group_rule" "ClusterComms-m-2-m-tcp" {
  description              = "master to master ClusterComms traffic - tcp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9999
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ClusterComms-w-2-m-tcp" {
  description              = "worker to master ClusterComms traffic - tcp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9999
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ClusterComms-m-2-m-udp" {
  description              = "master to master ClusterComms traffic - udp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9999
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ClusterComms-w-2-m-udp" {
  description              = "worker to master ClusterComms traffic -udp "
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9999
  protocol                 = "udp"
}

resource "aws_security_group_rule" "IngressKube-m-2-m-tcp" {
  description              = "master to master Kubernetes kubelet, scheduler and controller manager"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10259
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "IngressKube-w-2-m-tcp" {
  description              = "worker to master Kubernetes kubelet, scheduler and controller manager"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10259
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "Kubernetes-m-2-m-tcp" {
  description              = "master to master Kubernetes ingress services - tcp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "Kubernetes-w-2-m-tcp" {
  description              = "worker to master Kubernetes ingress services - tcp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "Kubernetes-m-2-m-udp" {
  description              = "master to master Kubernetes ingress services - udp"
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.master-sg.id
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "udp"
}

resource "aws_security_group_rule" "Kubernetes-w-2-m-udp" {
  description              = "worker to master Kubernetes ingress services -udp "
  security_group_id        = aws_security_group.master-sg.id
  source_security_group_id = aws_security_group.worker-sg.id
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "udp"
}
