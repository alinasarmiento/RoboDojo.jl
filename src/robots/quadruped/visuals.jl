function build_robot!(vis::Visualizer, model::Quadruped;
	r_body=0.02, r_thigh=0.0175, r_calf=0.0125, r_hip=0.02, r_knee=0.02, r_foot=0.02,
	color_opacity=1.0)

	body_mat = MeshPhongMaterial(color=RGBA(0.0, 0.0, 0.0, color_opacity))
	contact_mat = MeshPhongMaterial(color=RGBA(1.0, 165.0 / 255.0, 0.0, color_opacity))

	default_background!(vis)

	torso = GeometryBasics.Cylinder(Point3f0(0.0, 0.0, -model.l_torso2),
		Point3f0(0.0, 0.0, model.l_torso1),
		convert(Float32, r_body))
	setobject!(vis[:robot]["torso"], torso, body_mat)

	thigh_1 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_thigh1),
		convert(Float32, r_thigh))
	setobject!(vis[:robot]["thigh1"], thigh_1, body_mat)

	calf_1 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_calf1),
		convert(Float32, r_calf))
	setobject!(vis[:robot]["calf1"], calf_1, body_mat)

	thigh_2 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_thigh2),
		convert(Float32, r_thigh))
	setobject!(vis[:robot]["thigh2"], thigh_2, body_mat)

	calf_2 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_calf2),
		convert(Float32, r_calf))
	setobject!(vis[:robot]["calf2"], calf_2, body_mat)

	thigh_3 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_thigh3),
		convert(Float32, r_thigh))
	setobject!(vis[:robot]["thigh3"], thigh_3, body_mat)

	calf_3 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_calf3),
		convert(Float32, r_calf))
	setobject!(vis[:robot]["calf3"], calf_3, body_mat)

	thigh_4 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_thigh4),
		convert(Float32, r_thigh))
	setobject!(vis[:robot]["thigh4"], thigh_4, body_mat)

	calf_4 = GeometryBasics.Cylinder(Point3f0(0),
		Point3f0(0.0, 0.0, model.l_calf4),
		convert(Float32, r_calf))
	setobject!(vis[:robot]["calf4"], calf_4, body_mat)

	hip1 = setobject!(vis[:robot]["hip1"],
		GeometryBasics.Sphere(Point3f0(0), convert(Float32, r_hip)), body_mat)
	hip2 = setobject!(vis[:robot]["hip2"],
		GeometryBasics.Sphere(Point3f0(0), convert(Float32, r_hip)), body_mat)
	knee1 = setobject!(vis[:robot]["knee1"],
		GeometryBasics.Sphere(Point3f0(0), r_knee), body_mat)
	knee2 = setobject!(vis[:robot]["knee2"],
		GeometryBasics.Sphere(Point3f0(0), r_knee), body_mat)
	knee3 = setobject!(vis[:robot]["knee3"],
		GeometryBasics.Sphere(Point3f0(0), r_knee), body_mat)
	knee4 = setobject!(vis[:robot]["knee4"],
		GeometryBasics.Sphere(Point3f0(0), r_knee), body_mat)

	feet1 = setobject!(vis[:robot]["feet1"],
		GeometryBasics.Sphere(Point3f0(0), r_foot), contact_mat)
	feet2 = setobject!(vis[:robot]["feet2"],
		GeometryBasics.Sphere(Point3f0(0), r_foot), contact_mat)
	feet3 = setobject!(vis[:robot]["feet3"],
		GeometryBasics.Sphere(Point3f0(0), r_foot), contact_mat)
	feet4 = setobject!(vis[:robot]["feet4"],
		GeometryBasics.Sphere(Point3f0(0), r_foot), contact_mat)

	return true
end

function set_robot!(vis::Visualizer, model::Quadruped, q::AbstractVector;
		r_foot=0.02, y_offset=0.0)

	p_shift = [0.0; y_offset; r_foot]

	k_torso = q[1:2]
	p_torso = [k_torso[1], 0.0, k_torso[2]] + p_shift

	k_hip1 = kinematics_hip(model, q, hip=:hip1)
	p_hip1 = [k_hip1[1], 0.0, k_hip1[2]] + p_shift

	k_hip2 = kinematics_hip(model, q, hip=:hip2)
	p_hip2 = [k_hip2[1], 0.0, k_hip2[2]] + p_shift

	k_thigh_1 = kinematics_thigh(model, q, leg=:leg1, mode=:ee)
	p_thigh_1 = [k_thigh_1[1], 0.0, k_thigh_1[2]] + p_shift

	k_calf_1 = kinematics_calf(model, q, leg=:leg1, mode=:ee)
	p_calf_1 = [k_calf_1[1], 0.0, k_calf_1[2]] + p_shift

	k_thigh_2 = kinematics_thigh(model, q, leg=:leg2, mode=:ee)
	p_thigh_2 = [k_thigh_2[1], 0.0, k_thigh_2[2]] + p_shift

	k_calf_2 = kinematics_calf(model, q, leg=:leg2, mode=:ee)
	p_calf_2 = [k_calf_2[1], 0.0, k_calf_2[2]] + p_shift

	k_thigh_3 = kinematics_thigh(model, q, leg=:leg3, mode=:ee)
	p_thigh_3 = [k_thigh_3[1], 0.0, k_thigh_3[2]] + p_shift

	k_calf_3 = kinematics_calf(model, q, leg=:leg3, mode=:ee)
	p_calf_3 = [k_calf_3[1], 0.0, k_calf_3[2]] + p_shift

	k_thigh_4 = kinematics_thigh(model, q, leg=:leg4, mode=:ee)
	p_thigh_4 = [k_thigh_4[1], 0.0, k_thigh_4[2]] + p_shift

	k_calf_4 = kinematics_calf(model, q, leg=:leg4, mode=:ee)
	p_calf_4 = [k_calf_4[1], 0.0, k_calf_4[2]] + p_shift

	settransform!(vis[:robot]["thigh1"], cable_transform(p_hip1, p_thigh_1))
	settransform!(vis[:robot]["calf1"], cable_transform(p_thigh_1, p_calf_1))
	settransform!(vis[:robot]["thigh2"], cable_transform(p_hip1, p_thigh_2))
	settransform!(vis[:robot]["calf2"], cable_transform(p_thigh_2, p_calf_2))
	settransform!(vis[:robot]["thigh3"], cable_transform(p_hip2, p_thigh_3))
	settransform!(vis[:robot]["calf3"], cable_transform(p_thigh_3, p_calf_3))
	settransform!(vis[:robot]["thigh4"], cable_transform(p_hip2, p_thigh_4))
	settransform!(vis[:robot]["calf4"], cable_transform(p_thigh_4, p_calf_4))
	settransform!(vis[:robot]["torso"],
		compose(
			MeshCat.Translation(p_torso[1], p_torso[2], p_torso[3]),
			MeshCat.LinearMap(RotY(-q[3] + 0.5 * π))))
	settransform!(vis[:robot]["hip1"], MeshCat.Translation(p_hip1))
	settransform!(vis[:robot]["hip2"], MeshCat.Translation(p_hip2))
	settransform!(vis[:robot]["knee1"], MeshCat.Translation(p_thigh_1))
	settransform!(vis[:robot]["knee2"], MeshCat.Translation(p_thigh_2))
	settransform!(vis[:robot]["knee3"], MeshCat.Translation(p_thigh_3))
	settransform!(vis[:robot]["knee4"], MeshCat.Translation(p_thigh_4))
	settransform!(vis[:robot]["feet1"], MeshCat.Translation(p_calf_1))
	settransform!(vis[:robot]["feet2"], MeshCat.Translation(p_calf_2))
	settransform!(vis[:robot]["feet3"], MeshCat.Translation(p_calf_3))
	settransform!(vis[:robot]["feet4"], MeshCat.Translation(p_calf_4))

	return true
end

function visualize!(vis, model::Quadruped, q;
	Δt=0.1,
	r_body=0.02, r_thigh=0.0175, r_calf=0.0125, r_hip=0.02, r_knee=0.02, r_foot=0.02,
	color_opacity=1.0, fixed_camera=true)

	build_robot!(vis, model,
		r_body=r_body, r_thigh=r_thigh, r_calf=r_calf, r_hip=r_hip, r_knee=r_knee, r_foot=r_foot,
		color_opacity=color_opacity)

	anim = MeshCat.Animation(convert(Int, floor(1.0 / Δt)))

	for (t, qt) in enumerate(q)
		MeshCat.atframe(anim, t) do
			set_robot!(vis, model, qt)
		end
	end

	MeshCat.setanimation!(vis, anim)

	if fixed_camera
		settransform!(vis["/Cameras/default"],
        compose(Translation(0.0, -50.0, -1.0),LinearMap(RotZ(-pi / 2.0))))
        setprop!(vis["/Cameras/default/rotated/<object>"], "zoom", 25)
	end

	return true
end
